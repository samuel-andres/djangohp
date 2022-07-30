from unittest import signals

from django.db.models.signals import post_save, pre_delete, pre_save

from inquilinos.models import Cab

from .models import Huesped

# antes de guardar el objeto en la db se envía la señal set slug para que se setee un slug automático en base al nombre definido para la cabaña
pre_save.connect(Cab.set_slug, sender=Cab)
# antes de guardar el huesped en la base de datos se asigna su usuario al grupo huespedes para poder manejar los permisos automáticamente
pre_save.connect(Huesped.asignar_permiso, sender=Huesped)
