import datetime

from django.contrib.auth import get_user_model
from django.contrib.auth.models import Group
from django.core.validators import MaxValueValidator, MinValueValidator
from django.db import models
from django.db.models import Q
from django.urls import reverse
from django.utils.text import slugify

from .utils import CustomParser, EmailSender

# Create your models here.


class Huesped(models.Model):
    # attrs
    nombre = models.CharField(max_length=200)
    apellido = models.CharField(max_length=200)
    telefono = models.CharField(max_length=13)

    # punteros
    usuario = models.OneToOneField(
        get_user_model(),
        on_delete=models.CASCADE,
        related_name="huesped",
    )

    # métodos

    def asignar_permiso(sender, instance, *args, **kwargs):
        """agrega al huésped al grupo huesped"""
        group = Group.objects.get(name="huesped")
        instance.usuario.groups.add(group)

    def __str__(self) -> str:
        return f"{self.apellido.capitalize()}, {self.nombre.capitalize()}"

    class Meta:
        verbose_name_plural = "Huespedes"

    def get_absolute_url(self) -> str:
        """devuelve el url de la vista detalle del huesped(perfil)"""
        return reverse("inquilinos:hue-det", kwargs={"pk": self.pk})


class Estado(models.Model):
    # attrs
    nombre = models.CharField(max_length=200)
    ambito = models.CharField(max_length=200)

    # métodos

    def esAmbitoCabaña(self, ambito) -> bool:
        """toma como parámetro el ámbito y retorna True si el mismo es
        el ambito correspondiente a las cabañas"""
        if ambito == "cab":
            return True

    def esAmbitoReserva(self, ambito) -> bool:
        """toma como parámetro el ámbito y retorna True si el mismo es
        el ambito correspondiente a las reservas"""
        if ambito == "res":
            return True

    def __str__(self) -> str:
        if self.ambito == "cab":
            return f"{self.ambito.capitalize()}aña {self.nombre.capitalize()}"
        return f"{self.ambito.capitalize()}erva {self.nombre.capitalize()}"


class Cab(models.Model):
    # attrs
    nombre = models.CharField(
        max_length=200,
    )
    cantHabitaciones = models.IntegerField()
    costoPorNoche = models.FloatField(
        null=True,
    )
    slug = models.SlugField(null=False, blank=False, unique=True)

    # métodos
    def set_slug(sender, instance, *args, **kwargs):
        """método para utilizar en señales que setea el slug de la cab en el momento
        previo a que se guarde en la db"""

        if instance.slug:
            return
        instance.slug = slugify(instance.nombre)

    def get_fechas_habilitadas(self):
        """retorna todas las fechas habilitadas en [[d,h],[d,h],...]"""
        today = datetime.datetime.today()
        fechas_habilitadas = CustomParser.parseRanges(
            queryset=self.rango_set.filter(fechaHasta__gte=today), formatear=False
        )
        return fechas_habilitadas

    def get_reservas_abiertas(self):
        reservas_abiertas = self.reserva_set.filter(
            cambioestado__fechaFin__isnull=True
        ).exclude(
            Q(cambioestado__estado__nombre="Cancelada")
            | Q(cambioestado__estado__nombre="Finalizada")
            | Q(cambioestado__estado__nombre="Rechazada")
        )
        return reservas_abiertas

    def get_fechas_deshabilitadas(self):
        """retorna los rangos de reserva de todas las reservas asociadas
        a la cabaña en formato [[d,h],[d,h],...]"""

        fechas_deshabilitadas = CustomParser.parseRanges(
            queryset=self.get_reservas_abiertas(), formatear=True
        )
        return fechas_deshabilitadas

    def get_fechas_hab_y_des(self):
        """retorna una tupla (fechas_habilitadas, fechas_deshabilitadas)"""

        return (self.get_fechas_habilitadas, self.get_fechas_deshabilitadas)

    def crear_reserva(self, datos_reserva):
        """crea una nueva reserva asociada a la cabaña, y llama al método
        set_precio_final, set_estado y send_mail_enc_res de la nueva reserva.
        Toma como args=fechaDesde, fechaHasta, cantAdultos, cantMenores y huesped"""
        nueva_reserva = Reserva(
            fechaDesde=datos_reserva["fechaDesde"],
            fechaHasta=datos_reserva["fechaHasta"],
            cantAdultos=datos_reserva["cantAdultos"],
            cantMenores=datos_reserva["cantMenores"],
            cab=self,
            huesped=datos_reserva["huesped"],
        )
        nueva_reserva.set_precio_final()
        nueva_reserva.save()
        nueva_reserva.set_estado("Pte Confirmacion")
        # nueva_reserva.send_mail_enc_res()
        return nueva_reserva

    def __str__(self) -> str:
        return self.nombre

    class Meta:
        verbose_name = "Cabaña"
        verbose_name_plural = "Cabañas"
        ordering = [
            "-costoPorNoche",
            "-cantHabitaciones",
        ]


class Reserva(models.Model):
    # attrs
    fechaDesde = models.DateField()
    fechaHasta = models.DateField()
    fechaReserva = models.DateField(
        auto_now_add=True,
    )
    precioFinal = models.FloatField(
        null=True,
    )
    cantAdultos = models.PositiveSmallIntegerField(
        help_text="Cantidad de adultos",
        validators=[
            MinValueValidator(1),
            MaxValueValidator(5),
        ],
    )
    cantMenores = models.PositiveSmallIntegerField(
        help_text="Cantidad de niños",
        validators=[
            MinValueValidator(0),
            MaxValueValidator(5),
        ],
        null=True,
    )

    # punteros
    huesped = models.ForeignKey(
        Huesped, on_delete=models.CASCADE, null=True, blank=True
    )

    cab = models.ForeignKey(Cab, on_delete=models.CASCADE, null=True)

    # estado = models.ForeignKey(Estado, on_delete=models.SET_NULL, null=True)

    # métodos

    def cancelar_reserva(self):
        ultimo_cambio_estado = self.get_ultimo_cambio_estado()
        ultimo_cambio_estado.fechaFin = datetime.date.today()
        ultimo_cambio_estado.save()
        estado_cancelado = Estado.objects.get(nombre="Cancelada")
        nuevo_cambio_estado = CambioEstado(
            fechaInicio=datetime.date.today(), estado=estado_cancelado, reserva=self
        )
        nuevo_cambio_estado.save()

    def get_ultimo_cambio_estado(self):
        return self.cambioestado_set.get(fechaFin__isnull=True)

    def get_estado(self):
        """retorna el estado asociado al último cambioestado de la reserva,
        es decir, quien tiene la fechafin == Null"""
        ultimo_cambio_estado = self.get_ultimo_cambio_estado()
        return ultimo_cambio_estado.estado

    def get_cant_noches(self):
        """retorna la cantidad de noches correspondiente al rango de la reserva"""
        return (self.fechaHasta - self.fechaDesde).days

    def calcular_precio_final(self):
        """retorna el cálculo de precio final de la reserva"""
        return self.get_cant_noches() * self.cab.costoPorNoche

    def set_precio_final(self):
        """setea el precio final de la reserva llamando al método
        calcular_precio_final"""
        self.precioFinal = self.calcular_precio_final()

    def set_estado(self, nombre_estado):
        """toma como argumento el nombre del estado a setear y se encarga
        de manejar la creación y seteo del cambio estado -falta completar"""
        if not self.cambioestado_set.all().exists():
            cambioEstado = CambioEstado(
                estado=Estado.objects.get(nombre=nombre_estado),
                reserva=self,
            )
            cambioEstado.save()
        else:
            pass  # acá hay que completar el cambio de estado, setear fecha fin del anterior y crear uno nuevo

    def send_mail_enc_res(self):
        """envía el mail con los datos de la reserva al encargado de reservas utilizando
        el EmailSender"""
        EmailSender.mail_reserva(reserva=self, template_name="email_res_reg.html")

    def __str__(self) -> str:
        return f"{self.fechaDesde}->{self.fechaHasta}-{self.cab}"

    def get_precio_final(self) -> str:
        return f"$ {self.precioFinal}"

    class Meta:
        verbose_name_plural = "Reservas"
        permissions = (
            ("puede_registrar_reserva", "Este usuario puede registrar una reserva."),
        )


class Foto(models.Model):
    # attrs
    foto = models.ImageField(
        upload_to="cabs/",
    )
    descripcion = models.CharField(max_length=1000)
    # punteros
    cab = models.ForeignKey(Cab, on_delete=models.CASCADE, null=True)
    # métodos
    def __str__(self) -> str:
        return self.descripcion


class Rango(models.Model):
    # attrs
    fechaDesde = models.DateField()
    fechaHasta = models.DateField()
    # punteros
    cab = models.ForeignKey(Cab, on_delete=models.CASCADE, null=True)
    # métodos
    def __str__(self) -> str:
        return f"{self.fechaDesde}=>{self.fechaHasta}"


class Instalacion(models.Model):
    # attrs
    nombre = models.CharField(max_length=200)
    descripcion = models.CharField(max_length=500)
    # punteros
    cab = models.ManyToManyField(Cab)
    # métodos
    def __str__(self) -> str:
        return f"{self.descripcion}"

    class Meta:
        verbose_name_plural = "Instalaciones"


class CambioEstado(models.Model):
    # attrs
    estado = models.ForeignKey(Estado, on_delete=models.CASCADE)
    reserva = models.ForeignKey(Reserva, on_delete=models.CASCADE)
    fechaFin = models.DateField(
        null=True,
    )
    fechaInicio = models.DateField(
        auto_now_add=True,
    )
