from django.db import models
from django.urls import reverse
from django.utils.text import slugify
from django.contrib.auth.models import User, Group
from django.contrib.postgres.fields import DateRangeField
from bootstrap_daterangepicker import widgets
from datetime import date

# Create your models here.

class Huesped(models.Model):
    nombre = models.CharField(max_length=200)
    apellido = models.CharField(max_length=200)
    email = models.EmailField()
    telefono = models.CharField(max_length=13)
    usuario = models.OneToOneField(User, on_delete=models.CASCADE)

    def __str__(self) -> str:
        return f'{self.apellido}, {self.nombre}'

class Estado(models.Model):
    nombre = models.CharField(max_length=200)
    ambito = models.CharField(max_length=200)

    def __str__(self) -> str:
        # return f'{self.nombre}_{self.ambito}'
        return f'{self.nombre.capitalize()}'

class Cab(models.Model):
    # attrs
    nombre = models.CharField(
        max_length=200,
    )

    cantHabitaciones = models.IntegerField()

    # estado = models.ForeignKey(Estado, on_delete=models.RESTRICT)

    slug = models.SlugField(null=False, blank=False, unique=True)

    def set_slug(sender, instance, *args, **kwargs):
        if instance.slug:
            return
        instance.slug = slugify(
            instance.nombre)

    def __str__(self) -> str:
        return self.nombre

class Reserva(models.Model):
    # attrs
    fechaDesde = models.DateField()
    fechaHasta = models.DateField()
    # fechaDesdeHasta = DateRangeField(
    #     null=True,
    #     # widget=widgets.DateRangeWidget()
    # )
    ADULTOS = (
        (1, 'Uno'),
        (2, 'Dos'),
        (3, 'Tres'),
        (4, 'Cuatro'),
        (5, 'Cinco'),
    )

    cantAdultos = models.IntegerField(
        choices = ADULTOS,
        help_text = 'Cantidad de adultos',
    )

    huesped = models.ForeignKey(Huesped, on_delete=models.CASCADE, null=True, blank=True)

    cab = models.ForeignKey(Cab, on_delete=models.CASCADE, null=True)

    estado = models.ForeignKey(Estado, on_delete=models.SET_NULL, null=True)

    def __str__(self) -> str:
        return f'{self.fechaDesde}->{self.fechaHasta}-{self.cab.nombre}'

class Foto(models.Model):
    foto = models.ImageField(
        upload_to = 'cabs/',
    )
    descripcion = models.CharField(max_length=1000)
    cab = models.ForeignKey(Cab, on_delete=models.CASCADE, null=True)

    def __str__(self) -> str:
        return self.descripcion

# class Calendario(models.Model):
#     cab = models.ForeignKey(Cab, on_delete=models.CASCADE)
#     estado = models.ForeignKey(Estado, on_delete=models.SET_NULL, null=True)

class Rango(models.Model):
    fechaDesde = models.DateField()
    fechHasta = models.DateField()
    cab = models.ForeignKey(Cab, on_delete=models.CASCADE, null=True)

    def __str__(self) -> str:
        return f'{self.fechaDesde}=>{self.fechHasta}'

class Instalacion(models.Model):
    nombre = models.CharField(max_length=200)
    descripcion  = models.CharField(max_length=500)
    cab = models.ManyToManyField(Cab)