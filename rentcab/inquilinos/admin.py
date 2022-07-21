from django.contrib import admin
from .models import Cab, Rango, Reserva, Foto, Huesped, Estado, Rango, Instalacion

@admin.register(Cab)
class CabAdmin(admin.ModelAdmin):
    pass

# @admin.register(Calendario)
# class CalendarioAdmin(admin.ModelAdmin):
#     pass

@admin.register(Reserva)
class ReservaAdmin(admin.ModelAdmin):
    pass

@admin.register(Foto)
class FotoAdmin(admin.ModelAdmin):
    pass

@admin.register(Huesped)
class HuespedAdmin(admin.ModelAdmin):
    pass

@admin.register(Estado)
class EstadoAdmin(admin.ModelAdmin):
    pass

@admin.register(Rango)
class RangoAdmin(admin.ModelAdmin):
    pass

@admin.register(Instalacion)
class InstalacionAdmin(admin.ModelAdmin):
    pass

# Register your models here.
