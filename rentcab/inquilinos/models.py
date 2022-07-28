from django.db import models
from django.urls import reverse
from django.utils.text import slugify
from django.contrib.auth.models import User, Group
from django.contrib.postgres.fields import DateRangeField
from bootstrap_daterangepicker import widgets
from datetime import date
from django.core.validators import MaxValueValidator, MinValueValidator
# Create your models here.

class Huesped(models.Model):
    # attrs
    nombre = models.CharField(max_length=200)
    apellido = models.CharField(max_length=200)
    telefono = models.CharField(max_length=13)

    # punteros
    usuario = models.OneToOneField(User, on_delete=models.CASCADE)

    # métodos

    def asignar_permiso(sender, instance, *args, **kwargs):
        group = Group.objects.get(name='huesped')
        instance.usuario.groups.add(group)

    def __str__(self) -> str:
        return f"{self.apellido.capitalize()}, {self.nombre.capitalize()}"

    class Meta:
        verbose_name_plural = "Huespedes"

    def get_absolute_url(self):
        return reverse("inquilinos:hue-det", kwargs={"pk": self.pk})
    

class Estado(models.Model):
    # attrs
    nombre = models.CharField(max_length=200)
    ambito = models.CharField(max_length=200)

    # métodos
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
        null = True,
    )
    slug = models.SlugField(
        null=False, 
        blank=False, 
        unique=True
        )

    # métodos
    def set_slug(sender, instance, *args, **kwargs):
        if instance.slug:
            return
        instance.slug = slugify(instance.nombre)

    def __str__(self) -> str:
        return self.nombre

    class Meta:
        verbose_name = "Cabaña"
        verbose_name_plural = "Cabañas"
        ordering = [
            '-costoPorNoche',
            '-cantHabitaciones',
        ]


class Reserva(models.Model):
    # attrs
    fechaDesde = models.DateField()
    fechaHasta = models.DateField()
    fechaReserva = models.DateField(
        auto_now_add=True,
    )
    precioFinal = models.FloatField(
        null = True,
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

    estado = models.ForeignKey(Estado, on_delete=models.SET_NULL, null=True)

    # métodos
    def __str__(self) -> str:
        return f"{self.fechaDesde}->{self.fechaHasta}-{self.cab}"

    class Meta:
        verbose_name_plural = "Reservas"
        permissions = (
            ('puede_registrar_reserva', 'Este usuario puede registrar una reserva.'),
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
