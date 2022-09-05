from django.apps import AppConfig


class InquilinosConfig(AppConfig):
    default_auto_field = "django.db.models.BigAutoField"
    name = "inquilinos"

    def ready(self):
        import inquilinos.signals
