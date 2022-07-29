import datetime

from django.test import TestCase
from django.utils import timezone
from inquilinos.models import Cab, Rango, Reserva, Huesped
from inquilinos.forms import RegResForm, CrearHuespedForm
from django.contrib.auth.models import User


class RegistrarReservaFormTest(TestCase):
    # tests para la fechaDesde
    def test_fecha_desde_antes_de_hoy(self):
        """Testea que no sea exitosa la carga de una reserva con la fecha de ingreso menor
        a la fecha actual."""
        cab = Cab(nombre="foo_slug", cantHabitaciones=2)
        rango = Rango(
            fechaDesde=datetime.date.today(),
            fechaHasta=datetime.date.today() + datetime.timedelta(weeks=6),
            cab=cab,
        )
        cab.save()
        rango.save()
        fechaDesdeHasta = (
            (datetime.date.today() - datetime.timedelta(days=1)).strftime("%d/%m/%Y")
            + " - "
            + (datetime.date.today() + datetime.timedelta(weeks=4)).strftime("%d/%m/%Y")
        )
        foo_slug = "foo_slug"
        form = RegResForm(
            data={
                "fechaDesdeHasta": fechaDesdeHasta,
                "foo_slug": foo_slug,
                "cantAdultos": 2,
                "cantMenores": 2,
            }
        )
        self.assertFalse(form.is_valid())

    def test_fecha_desde_igual_a_hoy(self):
        """Testea que sea exitosa la carga de una reserva con la fecha de ingreso
        igual a la fecha actual."""
        cab = Cab(nombre="foo_slug", cantHabitaciones=2)
        rango = Rango(
            fechaDesde=datetime.date.today(),
            fechaHasta=datetime.date.today() + datetime.timedelta(weeks=6),
            cab=cab,
        )
        cab.save()
        rango.save()
        fechaDesdeHasta = (
            (datetime.date.today()).strftime("%d/%m/%Y")
            + " - "
            + (datetime.date.today() + datetime.timedelta(weeks=4)).strftime("%d/%m/%Y")
        )
        foo_slug = "foo_slug"
        form = RegResForm(
            data={
                "fechaDesdeHasta": fechaDesdeHasta,
                "foo_slug": foo_slug,
                "cantAdultos": 2,
                "cantMenores": 2,
            }
        )
        self.assertTrue(form.is_valid())

    def test_fecha_desde_fuera_de_rango_de_disponibilidad(self):
        """Testea que no sea exitosa la carga de una reserva en la que la fecha de ingreso
        no está dentro de ningún rango de disponibilidad de alquiler de la cabaña."""
        cab = Cab(nombre="foo_slug", cantHabitaciones=2)
        rango = Rango(
            fechaDesde=datetime.date.today(),
            fechaHasta=datetime.date.today() + datetime.timedelta(weeks=6),
            cab=cab,
        )
        cab.save()
        rango.save()
        fechaDesdeHasta = (
            (datetime.date.today() + datetime.timedelta(weeks=7)).strftime("%d/%m/%Y")
            + " - "
            + (datetime.date.today() + datetime.timedelta(weeks=8)).strftime("%d/%m/%Y")
        )
        foo_slug = "foo_slug"
        form = RegResForm(
            data={
                "fechaDesdeHasta": fechaDesdeHasta,
                "foo_slug": foo_slug,
                "cantAdultos": 2,
                "cantMenores": 2,
            }
        )
        self.assertFalse(form.is_valid())

    def test_fecha_desde_dentro_de_rango_de_una_reserva(self):
        """Testea que no sea exitosa la carga de una reserva que tiene la fecha de ingreso
        dentro de algún rango de reserva de la misma cabaña."""
        cab = Cab(nombre="foo_slug", cantHabitaciones=2)
        rango = Rango(
            fechaDesde=datetime.date.today(),
            fechaHasta=datetime.date.today() + datetime.timedelta(weeks=6),
            cab=cab,
        )
        reserva = Reserva(
            fechaDesde=datetime.date.today() + datetime.timedelta(weeks=2),
            fechaHasta=datetime.date.today() + datetime.timedelta(weeks=4),
            cantAdultos=2,
            cab=cab,
        )
        cab.save()
        rango.save()
        reserva.save()
        fechaDesdeHasta = (
            (datetime.date.today() + datetime.timedelta(weeks=3)).strftime("%d/%m/%Y")
            + " - "
            + (datetime.date.today() + datetime.timedelta(weeks=4)).strftime("%d/%m/%Y")
        )
        foo_slug = "foo_slug"
        form = RegResForm(
            data={
                "fechaDesdeHasta": fechaDesdeHasta,
                "foo_slug": foo_slug,
                "cantAdultos": 2,
                "cantMenores": 2,
            }
        )
        self.assertFalse(form.is_valid())

    # tests para la fechaHasta

    def test_fecha_hasta_antes_de_hoy(self):
        """Testea que no sea exitosa la carga de una reserva con la fecha hasta menor
        a la fecha actual."""
        cab = Cab(nombre="foo_slug", cantHabitaciones=2)
        rango = Rango(
            fechaDesde=datetime.date.today(),
            fechaHasta=datetime.date.today() + datetime.timedelta(weeks=6),
            cab=cab,
        )
        cab.save()
        rango.save()
        fechaDesdeHasta = (
            (datetime.date.today()).strftime("%d/%m/%Y")
            + " - "
            + (datetime.date.today() - datetime.timedelta(weeks=1)).strftime("%d/%m/%Y")
        )
        foo_slug = "foo_slug"
        form = RegResForm(
            data={
                "fechaDesdeHasta": fechaDesdeHasta,
                "foo_slug": foo_slug,
                "cantAdultos": 2,
                "cantMenores": 2,
            }
        )
        self.assertFalse(form.is_valid())

    def test_fecha_hasta_igual_a_hoy(self):
        """Testea que la carga de una reserva con la fecha hasta igual al día de la fecha
        no sea exitosa, debido al hecho de que la cantidad mínima de noches es = 1 (2 días)"""
        cab = Cab(nombre="foo_slug", cantHabitaciones=2)
        rango = Rango(
            fechaDesde=datetime.date.today(),
            fechaHasta=datetime.date.today() + datetime.timedelta(weeks=6),
            cab=cab,
        )
        cab.save()
        rango.save()
        fechaDesdeHasta = (
            (datetime.date.today()).strftime("%d/%m/%Y")
            + " - "
            + (datetime.date.today()).strftime("%d/%m/%Y")
        )
        foo_slug = "foo_slug"
        form = RegResForm(
            data={
                "fechaDesdeHasta": fechaDesdeHasta,
                "foo_slug": foo_slug,
                "cantAdultos": 2,
                "cantMenores": 2,
            }
        )
        self.assertFalse(form.is_valid())

    def test_fecha_hasta_fuera_de_rango_de_disponibilidad(self):
        """Testea que no sea exitosa la carga de una reserva con la fecha hasta fuera
        de rango de disponibilidad."""
        cab = Cab(nombre="foo_slug", cantHabitaciones=2)
        rango = Rango(
            fechaDesde=datetime.date.today(),
            fechaHasta=datetime.date.today() + datetime.timedelta(weeks=6),
            cab=cab,
        )
        cab.save()
        rango.save()
        fechaDesdeHasta = (
            (datetime.date.today() + datetime.timedelta(weeks=1)).strftime("%d/%m/%Y")
            + " - "
            + (datetime.date.today() + datetime.timedelta(weeks=8)).strftime("%d/%m/%Y")
        )
        foo_slug = "foo_slug"
        form = RegResForm(
            data={
                "fechaDesdeHasta": fechaDesdeHasta,
                "foo_slug": foo_slug,
                "cantAdultos": 2,
                "cantMenores": 2,
            }
        )
        self.assertFalse(form.is_valid())

    def test_fecha_hasta_dentro_de_rango_de_una_reserva(self):
        """Testea que no sea exitosa la carga de una reserva con la fecha hasta dentro
        del rango de alguna reserva de la cabaña."""
        cab = Cab(nombre="foo_slug", cantHabitaciones=2)
        rango = Rango(
            fechaDesde=datetime.date.today(),
            fechaHasta=datetime.date.today() + datetime.timedelta(weeks=6),
            cab=cab,
        )
        reserva = Reserva(
            fechaDesde=datetime.date.today() + datetime.timedelta(weeks=2),
            fechaHasta=datetime.date.today() + datetime.timedelta(weeks=4),
            cantAdultos=2,
            cab=cab,
        )
        cab.save()
        rango.save()
        reserva.save()
        fechaDesdeHasta = (
            (datetime.date.today() + datetime.timedelta(weeks=1)).strftime("%d/%m/%Y")
            + " - "
            + (datetime.date.today() + datetime.timedelta(weeks=3)).strftime("%d/%m/%Y")
        )
        foo_slug = "foo_slug"
        form = RegResForm(
            data={
                "fechaDesdeHasta": fechaDesdeHasta,
                "foo_slug": foo_slug,
                "cantAdultos": 2,
                "cantMenores": 2,
            }
        )
        self.assertFalse(form.is_valid())

    # tests para las fechas dentro del rango ingresado

    def test_fecha_en_rango_ingresado_fuera_de_rango_de_disponibilidad(self):
        """Testea que no sea exitosa la carga de una reserva la cual tiene alguna fecha
        dentro de su rango fuera de algún rango de disponibilidad."""
        cab = Cab(nombre="foo_slug", cantHabitaciones=2)
        rango1 = Rango(
            fechaDesde=datetime.date.today(),
            fechaHasta=datetime.date.today() + datetime.timedelta(weeks=4),
            cab=cab,
        )
        rango2 = Rango(
            fechaDesde=datetime.date.today() + datetime.timedelta(weeks=6),
            fechaHasta=datetime.date.today() + datetime.timedelta(weeks=8),
            cab=cab,
        )
        cab.save()
        rango1.save()
        rango2.save()
        fechaDesdeHasta = (
            (datetime.date.today() + datetime.timedelta(weeks=1)).strftime("%d/%m/%Y")
            + " - "
            + (datetime.date.today() + datetime.timedelta(weeks=7)).strftime("%d/%m/%Y")
        )
        foo_slug = "foo_slug"
        form = RegResForm(
            data={
                "fechaDesdeHasta": fechaDesdeHasta,
                "foo_slug": foo_slug,
                "cantAdultos": 2,
                "cantMenores": 2,
            }
        )
        self.assertFalse(form.is_valid())

    def test_fecha_en_rango_ingresado_dentro_de_rango_de_una_reserva(self):
        """Testea que no sea exitosa la carga de una reserva la cual tiene alguna fecha
        en su rango dentro del rango de alguna reserva de la cabaña."""
        cab = Cab(nombre="foo_slug", cantHabitaciones=2)
        rango = Rango(
            fechaDesde=datetime.date.today(),
            fechaHasta=datetime.date.today() + datetime.timedelta(weeks=5),
            cab=cab,
        )
        reserva = Reserva(
            fechaDesde=datetime.date.today() + datetime.timedelta(weeks=2),
            fechaHasta=datetime.date.today() + datetime.timedelta(weeks=3),
            cantAdultos=2,
            cab=cab,
        )
        cab.save()
        rango.save()
        reserva.save()
        fechaDesdeHasta = (
            (datetime.date.today() + datetime.timedelta(weeks=1)).strftime("%d/%m/%Y")
            + " - "
            + (datetime.date.today() + datetime.timedelta(weeks=4)).strftime("%d/%m/%Y")
        )
        foo_slug = "foo_slug"
        form = RegResForm(
            data={
                "fechaDesdeHasta": fechaDesdeHasta,
                "foo_slug": foo_slug,
                "cantAdultos": 2,
                "cantMenores": 2,
            }
        )
        self.assertFalse(form.is_valid())

    # los tests de cantidad de adultos y menores no los escribo todavía pq hay que definir
    # bien cómo es el límite, ahora la aplicación funciona con un máximo de 5 personas por
    # cabaña, entre adultos y menores, y con como mínimo, un adulto.


class RegistrarHuespedFormTest(TestCase):
    def test_datos_correctos(self):
        form = CrearHuespedForm(
            data={
                "nombre": "Samuel",
                "apellido": "Andres",
                "telefono": "3534237553",
            }
        )
        self.assertTrue(form.is_valid())

    def test_sin_ingresar_telefono(self):
        form = CrearHuespedForm(
            data={
                "nombre": "Samuel",
                "apellido": "Andres",
            }
        )
        self.assertFalse(form.is_valid())

    def test_sin_ingresar_apellido(self):
        form = CrearHuespedForm(
            data={
                "nombre": "Samuel",
                "telefono": "3534237553",
            }
        )
        self.assertFalse(form.is_valid())

    def test_sin_ingresar_nombre(self):
        form = CrearHuespedForm(
            data={
                "apellido": "Andres",
                "telefono": "3534237553",
            }
        )
        self.assertFalse(form.is_valid())
