import datetime
from django.contrib.auth.models import Group, Permission
from django.contrib.auth import get_user_model
from django.test import TestCase
from django.urls import reverse

from inquilinos.models import (Cab, Huesped, Rango,
                               Reserva)


class RegistroReservaViewTest(TestCase):
    def setUp(self):
        # Creación de un usuario para testeo
        self.user = get_user_model().objects.create_user(
            username="testuser1", password="1X<ISRUkw+tuK", email="test@test.com"
        )
        self.user.save()

        # creación de una cabaña
        test_cab = Cab(nombre="cab_test", cantHabitaciones=2, costoPorNoche=2500.0)
        test_cab.save()

        # creación de un rango y una reserva
        test_rango = Rango(
            fechaDesde=datetime.date.today() - datetime.timedelta(weeks=2),
            fechaHasta=datetime.date.today() + datetime.timedelta(weeks=2),
        )
        reserva = Reserva(
            fechaDesde=datetime.date.today(),
            fechaHasta=datetime.date.today() + datetime.timedelta(weeks=1),
            cantAdultos=1,
        )
        reserva.save()
        test_rango.save()
        # creación del grupo con el que se manejan los permisos de la vista
        group = Group(name="huesped")
        group.save()
        # se agrega el permiso al grupo
        permission = Permission.objects.get(codename="puede_registrar_reserva")
        permission.save()
        group.permissions.add(permission)

    def test_redirect_si_no_esta_logueado(self):
        """Testea que se rediriga al usuario correctamente cuando intenta registrar una reserva
        sin estar logueado"""
        response = self.client.get(
            reverse("inquilinos:reg-res", kwargs={"slug": "cab_test"})
        )
        self.assertRedirects(
            response, "/accounts/login/?next=/inquilinos/cab/cab_test/reservar"
        )

    def test_code_403_si_no_completo_datos_personales(self):
        """Testea que se prohiba el acceso al usuario aún estando logueado si no completó sus
        datos personales"""
        login = self.client.login(username="testuser1", password="1X<ISRUkw+tuK")
        response = self.client.get(
            reverse("inquilinos:reg-res", kwargs={"slug": "cab_test"})
        )
        self.assertEqual(response.status_code, 403)

    def test_code_200_si_completo_datos_personales(self):
        """Testea que el usuario tenga acceso al registro de reservas si está logueado y completó sus
        datos personales"""
        huesped = Huesped(
            usuario=self.user,
            nombre="nombre_test",
            apellido="apellido_test",
            telefono="3534267889",
        )
        huesped.save()
        login = self.client.login(username="testuser1", password="1X<ISRUkw+tuK")
        response2 = self.client.get(
            reverse("inquilinos:reg-res", kwargs={"slug": "cab_test"})
        )
        self.assertEqual(response2.status_code, 200)
