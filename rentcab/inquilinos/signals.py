from unittest import signals
from django.db.models.signals import pre_save, post_save, pre_delete
from inquilinos.models import Cab

# antes de guardar el objeto en la db se envía la señal set slug para que se setee un slug automático en base al nombre definido para la cabaña
pre_save.connect(Cab.set_slug, sender=Cab)
