import datetime

from django.contrib.auth import get_user_model
from django.contrib.auth.models import Group, Permission
from django.test import TestCase
from django.urls import reverse
from rest_framework import status

from inquilinos.models import Cab, Huesped, Rango, Reserva, Estado

def get_a_huesped(user):
    huesped = Huesped(
        usuario=user,
        nombre="nombre_test",
        apellido="apellido_test",
        telefono="3534267889",
    )

    huesped.save()
    return huesped

def crear_reserva(cab,
    user,
    fechaDesde=datetime.date.today(),
    fechaHasta=datetime.date.today() + datetime.timedelta(weeks=2),
    cantAdultos=2,
    cantMenores=2
    ):
    huesped = get_a_huesped(user)
    datos_reserva = {
        "fechaDesde": fechaDesde,
        "fechaHasta": fechaHasta,
        "cantAdultos": cantAdultos,
        "cantMenores": cantMenores,
        "huesped": huesped,
    }
    reserva = cab.crear_reserva(datos_reserva)
    return reserva


class RegistroReservaViewTest(TestCase):
    def setUp(self):
        # Creación de un usuario para testeo
        self.user = get_user_model().objects.create_user(
            username="testuser1", password="1X<ISRUkw+tuK", email="test@test.com"
        )
        self.user.save()

        # creación de una cabaña
        test_cab = Cab(
            nombre="cab_test",
            cantHabitaciones=2,
            costoPorAdulto=500.0,
            costoPorMenor=200.0,
        )
        test_cab.save()

        # creación de un rango y una reserva
        test_rango = Rango(
            fechaDesde=datetime.date.today() - datetime.timedelta(weeks=2),
            fechaHasta=datetime.date.today() + datetime.timedelta(weeks=2),
        )
        test_reserva = Reserva(
            fechaDesde=datetime.date.today(),
            fechaHasta=datetime.date.today() + datetime.timedelta(weeks=1),
            cantAdultos=1,
        )
        test_reserva.save()
        test_rango.save()
        # creación del grupo con el que se manejan los permisos de la vista
        group = Group(name="huesped")
        group.save()
        # se agrega el permiso al grupo
        permission1 = Permission.objects.get(codename="puede_registrar_reserva")
        permission1.save()
        group.permissions.add(permission1)

    def test_redirect_si_no_esta_logueado(self):
        """Testea que se rediriga al usuario correctamente cuando intenta registrar una reserva
        sin estar logueado"""
        response = self.client.get(
            reverse("inquilinos:reserva-registro", kwargs={"slug": "cab_test"})
        )
        self.assertRedirects(
            response, "/accounts/login/?next=/inquilinos/cab/cab_test/reservar"
        )

    def test_code_403_si_no_completo_datos_personales(self):
        """Testea que se prohiba el acceso al usuario aún estando logueado si no completó sus
        datos personales"""
        self.client.login(username="testuser1", password="1X<ISRUkw+tuK")
        response = self.client.get(
            reverse("inquilinos:reserva-registro", kwargs={"slug": "cab_test"})
        )
        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

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
        self.client.login(username="testuser1", password="1X<ISRUkw+tuK")
        response = self.client.get(
            reverse("inquilinos:reserva-registro", kwargs={"slug": "cab_test"})
        )
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_mensaje_correcto_si_es_admin(self):
        """Testea que se muestre el mensaje correcto si un usuario
        con una cuenta de administrador intenta ingresar a la vista
        de registro de reservas."""

        self.user = get_user_model().objects.create_superuser(
            username="admin", password="1X<ISRUkw+tuK", email="admin@test.com"
        )
        self.user.save()
        self.client.login(username="admin", password="1X<ISRUkw+tuK")

        response = self.client.get(
            reverse("inquilinos:reserva-registro", kwargs={"slug": "cab_test"})
        )
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertTemplateUsed(response, 'inquilinos/registro_reserva.html')
        self.assertContains(response, """Por favor, logueate con una cuenta de cliente
      para probar el registro de reservas.""")

class ReservasListViewTest(TestCase):
    """Test case de la vista de lista de reservas"""
    def setUp(self):
        # Creación de un usuario para testeo
        self.user = get_user_model().objects.create_user(
            username="testuser1", password="1X<ISRUkw+tuK", email="test@test.com"
        )
        self.user.save()

        # creación de una cabaña
        test_cab = Cab(
            nombre="cab_test",
            cantHabitaciones=2,
            costoPorAdulto=500.0,
            costoPorMenor=200.0,
        )
        test_cab.save()

        # creación de un rango y una reserva
        test_rango = Rango(
            fechaDesde=datetime.date.today() - datetime.timedelta(weeks=2),
            fechaHasta=datetime.date.today() + datetime.timedelta(weeks=2),
        )
        test_rango.save()
        # creación del grupo con el que se manejan los permisos de la vista
        group = Group(name="huesped")
        group.save()
        # se agrega el permiso al grupo
        permission1 = Permission.objects.get(codename="puede_registrar_reserva")
        permission2 = Permission.objects.get(codename="puede_consultar_reserva")
        permission1.save()
        permission2.save()
        group.permissions.add(permission1)
        group.permissions.add(permission2)

        # creación de estados
        PteConf = Estado(nombre="Pte Confirmacion")
        Cancelada = Estado(nombre="Cancelada")
        Finalizada = Estado(nombre="Finalizada")
        Confirmada = Estado(nombre="Confirmada")
        Rechazada = Estado(nombre="Rechazada")
        Cancelada.save()
        Finalizada.save()
        Confirmada.save()
        Rechazada.save()
        PteConf.save()

    def test_redirect_si_no_esta_logueado(self):
        """Testea que se rediriga al usuario correctamente cuando intenta acceder a
        la vista lista de reservas si no esta logueado"""
        response = self.client.get(
            reverse("inquilinos:reserva-list")
        )
        self.assertRedirects(
            response, "/accounts/login/?next=/inquilinos/reservas/"
        )

    def test_403_si_usuario_no_es_huesped(self):
        """Testea que se devuelva un response forbidden si el usuario
        no completo sus datos personales e intenta acceder a su lista de reservas"""
        self.client.login(username="testuser1", password="1X<ISRUkw+tuK")
        response = self.client.get(
            reverse("inquilinos:reserva-list")
        )
        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_mensaje_correcto_en_403_si_usuario_es_admin(self):
        """Testea que se devuelva el mensaje correcto si el usuario es administrador
        e intenta acceder a su lista de reservas"""

        self.user = get_user_model().objects.create_superuser(
            username="admin", password="1X<ISRUkw+tuK", email="admin@test.com"
        )
        self.user.save()
        self.client.login(username="admin", password="1X<ISRUkw+tuK")

        response = self.client.get(
            reverse("inquilinos:reserva-list",)
        )

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)
        self.assertTemplateUsed(response, '403.html',)
        self.assertRaisesMessage(response, """Para probar la consulta de reservas en la sección de inquilinos debes loguearte con una cuenta de cliente.""")

    def test_mensaje_correcto_en_403_si_usuario_es_plano(self):
        """Testea que se devuelva el mensaje correcto si el usuario es plano
        e intenta acceder a su lista de reservas"""
        self.client.login(username="testuser1", password="1X<ISRUkw+tuK")

        response = self.client.get(
            reverse("inquilinos:reserva-list",)
        )

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)
        self.assertTemplateUsed(response, '403.html',)
        self.assertRaisesMessage(response, """Para consultar tus reservas debes completar tus datos personales.""")

    def test_mensaje_correcto_si_huesped_no_tiene_reservas(self):
        """Testea que se devuelva el mensaje correcto si huesped no tiene reservas
        e intenta acceder a su lista de reservas"""
        huesped = Huesped(
            usuario=self.user,
            nombre="nombre_test",
            apellido="apellido_test",
            telefono="3534267889",
        )
        huesped.save()
        self.client.login(username="testuser1", password="1X<ISRUkw+tuK")

        response = self.client.get(
            reverse("inquilinos:reserva-list",)
        )
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertTemplateUsed(response, "inquilinos/reservas_list.html")
        self.assertContains(response, "Todavía no registraste ninguna reserva.",)

    def test_reserva_de_huesped_aparece_en_la_lista(self):
        """Testea que aparezcan las reservas de un huesped en la vista
        de lista de reservas"""
        cab = Cab.objects.get(slug="cab_test")

        self.client.login(username="testuser1", password="1X<ISRUkw+tuK")

        reserva = crear_reserva(user=self.user, cab=cab)

        response = self.client.get(
            reverse("inquilinos:reserva-list",)
        )

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertTemplateUsed(response, "inquilinos/reservas_list.html")
        self.assertContains(response, f'<th scope="row">{reserva.pk}</th>',)


    def test_reserva_de_otro_huesped_no_aparece_en_la_lista(self):
        """Testea que solo aparezcan las reservas de un huesped en la vista
        de lista de reservas y no las de otro huesped"""
        cab = Cab.objects.get(slug="cab_test")

        self.client.login(username="testuser1", password="1X<ISRUkw+tuK")

        reserva1 = crear_reserva(user=self.user, cab=cab)

        user2 = get_user_model().objects.create_user(
            username="testuser2", password="1X<ISRUkw+tuK", email="test2@test2.com"
        )
        user2.save()

        reserva2= crear_reserva(user=user2, cab=cab)
        response = self.client.get(
            reverse("inquilinos:reserva-list",)
        )

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertTemplateUsed(response, "inquilinos/reservas_list.html")
        self.assertContains(response, f'<th scope="row">{reserva1.pk}</th>',)
        self.assertNotContains(response, f'<th scope="row">{reserva2.pk}</th>',)

class ReservaDetailViewTest(TestCase):
    """Test case para la vista detalle de reserva"""
    def setUp(self):
        # Creación de un usuario para testeo
        self.user = get_user_model().objects.create_user(
            username="testuser1", password="1X<ISRUkw+tuK", email="test@test.com"
        )
        self.user.save()

        # creación de una cabaña
        test_cab = Cab(
            nombre="cab_test",
            cantHabitaciones=2,
            costoPorAdulto=500.0,
            costoPorMenor=200.0,
        )
        test_cab.save()

        # creación de un rango y una reserva
        test_rango = Rango(
            fechaDesde=datetime.date.today() - datetime.timedelta(weeks=2),
            fechaHasta=datetime.date.today() + datetime.timedelta(weeks=2),
        )
        test_rango.save()
        # creación del grupo con el que se manejan los permisos de la vista
        group = Group(name="huesped")
        group.save()
        # se agrega el permiso al grupo
        permission1 = Permission.objects.get(codename="puede_registrar_reserva")
        permission2 = Permission.objects.get(codename="puede_consultar_reserva")
        permission1.save()
        permission2.save()
        group.permissions.add(permission1)
        group.permissions.add(permission2)

        # creación de estados
        PteConf = Estado(nombre="Pte Confirmacion")
        Cancelada = Estado(nombre="Cancelada")
        Finalizada = Estado(nombre="Finalizada")
        Confirmada = Estado(nombre="Confirmada")
        Rechazada = Estado(nombre="Rechazada")
        Cancelada.save()
        Finalizada.save()
        Confirmada.save()
        Rechazada.save()
        PteConf.save()


    def test_403_mensaje_correcto_si_usuario_es_admin(self):
        """Testea que el mensaje sea correcto cuando el admin
        intenta ingresar a la vista detalle de una reserva
        desde la aplicación de inquilinos"""

        self.user = get_user_model().objects.create_superuser(
            username="admin", password="1X<ISRUkw+tuK", email="admin@test.com"
        )
        self.user.save()
        self.client.login(username="admin", password="1X<ISRUkw+tuK")

        user_huesped = get_user_model().objects.create_user(
            username="testuser",
            password="1X<ISRUkw+tuK",
            email="testuser@test.com",)

        user_huesped.save()

        reserva = crear_reserva(
            user=user_huesped,
            cab = Cab.objects.get(slug='cab_test'))

        response = self.client.get(
            reverse("inquilinos:reserva-detail", kwargs={"pk": reserva.pk})
        )

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)
        self.assertTemplateUsed(response, '403.html',)
        self.assertRaisesMessage(response, """Para probar la consulta de detalle de reserva en la sección de inquilinos debes loguearte con una cuenta de cliente.""")

    def test_huesped_puede_consultar_detalle_de_una_reserva_suya(self):
        """Testea que un usuario pueda consultar el detalle de una reserva
        que registró"""

        self.client.login(username="testuser1", password="1X<ISRUkw+tuK")
        reserva = crear_reserva(
            user=self.user,
            cab = Cab.objects.get(slug='cab_test'))

        response = self.client.get(
            reverse("inquilinos:reserva-detail", kwargs={"pk": reserva.pk})
        )

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertTemplateUsed(response, "inquilinos/reserva_detail.html")
        self.assertContains(response, f'<h1>Reserva #{reserva.pk}</h1>')

    def test_huesped_no_puede_consultar_detalle_de_reserva_de_otro(self):
        """Testea que un huesped no pueda consultar el detalle reserva de
        otro huesped"""

        self.client.login(username="testuser1", password="1X<ISRUkw+tuK")

        otro_huesped = get_user_model().objects.create_user(username="otro_huesped", password="1X<ISRUkw+tuK", email="otro@test.com")

        reserva = crear_reserva(
            user=otro_huesped,
            cab = Cab.objects.get(slug='cab_test'))

        response = self.client.get(
            reverse("inquilinos:reserva-detail", kwargs={"pk": reserva.pk})
        )

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)
        self.assertTemplateUsed(response, "403.html")
        self.assertRaisesMessage(response, "Esta reserva no te pertenece.")