from pathlib import Path

from django.urls import path

from . import views

# namespace
app_name = "inquilinos"
urlpatterns = [
    # HOMEPAGE
    path("", views.IndexView.as_view(), name="index"),
    # Vistas de cabaña
    path("cab/<slug:slug>", views.CabDetailView.as_view(), name="cab-detail"),
    path(
        "cab/<slug:slug>/reservar",
        views.RegistroReservaView.as_view(),
        name="reserva-registro",
    ),
    # Vistas de huesped
    path("huesped/<int:pk>", views.HuespedDetailView.as_view(), name="huesped-detail"),
    path("huesped/perfil/", views.HuespedCreateView.as_view(), name="huesped-registro"),
    path(
        "huesped/perfil/editar",
        views.HuespedUpdateView.as_view(),
        name="huesped-update",
    ),
    # Vistas de reserva
    path("reservas/", views.ReservasListView.as_view(), name="reserva-list"),
    path("reservas/<int:pk>", views.ReservaDetailView.as_view(), name="reserva-detail"),
    path(
        "reservas/<int:pk>/cancelar",
        views.CancelarReservaView.as_view(),
        name="reserva-cancelar",
    ),
    path(
        "reservas/<int:pk>/calificar",
        views.ComentarioCreateView.as_view(),
        name="comentario-registro",
    ),
]
