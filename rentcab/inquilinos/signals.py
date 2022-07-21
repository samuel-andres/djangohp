from unittest import signals
from django.db.models.signals import pre_save, post_save, pre_delete
from inquilinos.models import Cab

pre_save.connect(Cab.set_slug, sender=Cab)