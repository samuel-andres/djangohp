from django.urls import path

from .views import RegistrarseView

app_name = 'accounts'
urlpatterns = [
    path("registrarse/", RegistrarseView.as_view(), name="sign-up"),
]
