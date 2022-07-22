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
    email = models.EmailField()
    telefono = models.CharField(max_length=13)

    # punteros
    usuario = models.OneToOneField(User, on_delete=models.CASCADE)

    # métodos
    def __str__(self) -> str:
        return f"{self.apellido}, {self.nombre}"

    class Meta:
        verbose_name_plural = 'Huespedes'


class Estado(models.Model):
    # attrs
    nombre = models.CharField(max_length=200)
    ambito = models.CharField(max_length=200)

    # métodos
    def __str__(self) -> str:
        if self.ambito == 'cab':
            return f'{self.ambito.capitalize()}aña {self.nombre.capitalize()}'
        return f'{self.ambito.capitalize()}erva {self.nombre.capitalize()}'


class Cab(models.Model):
    # attrs
    nombre = models.CharField(
        max_length=200,
    )
    cantHabitaciones = models.IntegerField()
    slug = models.SlugField(null=False, blank=False, unique=True)

    # métodos
    def set_slug(sender, instance, *args, **kwargs):
        if instance.slug:
            return
        instance.slug = slugify(instance.nombre)

    def __str__(self) -> str:
        return self.nombre

    class Meta:
        verbose_name = 'Cabaña'
        verbose_name_plural = 'Cabañas'


class Reserva(models.Model):
    # attrs
    fechaDesde = models.DateField()
    fechaHasta = models.DateField()
    cantAdultos = models.PositiveIntegerField(
        help_text="Cantidad de adultos",
        validators=[
            MinValueValidator(1),
            MaxValueValidator(5),
        ],
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
        verbose_name_plural = 'Reservas'


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
    fechHasta = models.DateField()
    # punteros
    cab = models.ForeignKey(Cab, on_delete=models.CASCADE, null=True)
    # métodos
    def __str__(self) -> str:
        return f"{self.fechaDesde}=>{self.fechHasta}"


class Instalacion(models.Model):
    # attrs
    nombre = models.CharField(max_length=200)
    descripcion = models.CharField(max_length=500)
    # punteros
    cab = models.ManyToManyField(Cab)
    # métodos
    def __str__(self) -> str:
        return f'{self.descripcion}'
    
    class Meta:
        verbose_name_plural = 'Instalaciones'
