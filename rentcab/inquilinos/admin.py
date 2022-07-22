from django.contrib import admin
from .models import Cab, Rango, Reserva, Foto, Huesped, Estado, Rango, Instalacion


class FotosInLine(admin.StackedInline):
    model = Foto
    extra = 1

class RangosInLine(admin.StackedInline):
    model = Rango
    extra = 0

class InstalacionesInLine(admin.TabularInline):
    model = Instalacion.cab.through
    extra = 0

@admin.register(Cab)
class CabAdmin(admin.ModelAdmin):
    list_display = ('nombre', 'cantHabitaciones', 'slug',)
    exclude=('slug',)
    inlines = [
        FotosInLine,
        RangosInLine,
        InstalacionesInLine,
        ]


# @admin.register(Calendario)
# class CalendarioAdmin(admin.ModelAdmin):
#     pass


@admin.register(Reserva)
class ReservaAdmin(admin.ModelAdmin):
    list_filter = ("fechaDesde", "fechaHasta")


@admin.register(Foto)
class FotoAdmin(admin.ModelAdmin):
    pass


@admin.register(Huesped)
class HuespedAdmin(admin.ModelAdmin):
    pass


@admin.register(Estado)
class EstadoAdmin(admin.ModelAdmin):
    list_filter = ('ambito',)


@admin.register(Rango)
class RangoAdmin(admin.ModelAdmin):
    pass


@admin.register(Instalacion)
class InstalacionAdmin(admin.ModelAdmin):
    pass


# Register your models here.
