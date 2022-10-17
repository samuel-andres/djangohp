from django.db import models
from inquilinos.models import Cab, Huesped, Reserva , Rango,Foto , Instalacion
# Create your models here.
class Servicio(models.Model):
    # attrs
    nombre = models.CharField(max_length=200)
    descripcion = models.CharField(max_length=500)
    baja=models.BooleanField(default=0)
    # punteros
    # métodos
    def __str__(self) -> str:
        return f"{self.descripcion}"

    class Meta:
        verbose_name_plural = "Servicios"

class Promocion(models.Model):
    # attrs
    descripcion = models.CharField(max_length=500)
    titulo = models.CharField(max_length=50)
    fechaInicio = models.DateField()
    fechaFin = models.DateField()
    descuento=models.IntegerField()
    baja=models.BooleanField(default=0)
    # punteros 
    cab = models.ForeignKey(Cab, on_delete=models.CASCADE, null=True)
    foto= models.ForeignKey(Foto, on_delete=models.CASCADE, null=True)