from pathlib import Path

from django.urls import path

from . import views

# namespace
app_name = "inquilinos"
urlpatterns = [
    # HOMEPAGE
    path("", views.IndexView.as_view(), name="index"),
    # DetailViews
    path("cab/<slug:slug>", views.CabDetailView.as_view(), name="cab-det"),
    path("huesped/<int:pk>", views.PerfilHuespedDetailView.as_view(), name="hue-det"),
    path(
        "reservas/<int:pk>", views.ReservaDetailAndCancelView.as_view(), name="res-det"
    ),
    # CreateViews
    path(
        "huesped/perfil/", views.CrearPerfilHuespedView.as_view(), name="crear-huesped"
    ),
    # ListViews
    path("reservas/", views.ReservasDeHuespedListView.as_view(), name="res-h-list"),
    # CustomViews
    path(
        "cab/<slug:slug>/reservar", views.RegistroReservaView.as_view(), name="reg-res"
    ),
    path("test/", views.test_view),
]
