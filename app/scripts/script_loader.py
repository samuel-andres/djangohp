from django.contrib.auth import get_user_model
from django.contrib.auth.models import Group, Permission
from inquilinos.models import Estado, Cab, Foto

def run():
    
    Estado.objects.all().delete()
    Group.objects.all().delete()
        

    # creación de grupo
    group = Group(name="huesped")
    group.save()

   # creación de permisos
    permission1 = Permission.objects.get(codename="puede_registrar_reserva")
    permission2 = Permission.objects.get(codename="puede_cancelar_reserva")
    permission3 = Permission.objects.get(codename="puede_consultar_reserva")
    permission1.save()
    permission2.save()
    permission3.save()

    # asignación de permisos
    group.permissions.add(permission1)
    group.permissions.add(permission2)
    group.permissions.add(permission3)

    # crecion de superusuario
    admin = get_user_model().objects.create_superuser('admin', 'admin@example.com', 'admin')

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
