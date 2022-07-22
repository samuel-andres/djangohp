from django.urls import path
from . import views

app_name = "propietarios"
urlpatterns = [
    # HOMEPAGE
    path("", views.IndexView.as_view(), name="index"),
]
