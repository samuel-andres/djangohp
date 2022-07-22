from django.urls import path
from . import views

app_name = "inquilinos"
urlpatterns = [
    # HOMEPAGE
    path("", views.IndexView.as_view(), name="index"),
    path("cab/<slug:slug>", views.CabDetailView.as_view(), name="cab-det"),
    path(
        "cab/<slug:slug>/reservar", views.RegistroReservaView.as_view(), name="reg-res"
    ),
]
