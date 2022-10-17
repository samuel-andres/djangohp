from django.urls import path
from django.contrib.auth.decorators import login_required
from .views import *
from . import views

app_name = "propietarios"
urlpatterns = [
    # HOMEPAGE
    path("", views.IndexView.as_view(), name="index"),
    path('inicialAdmin', login_required(InicioAdmin.as_view()), name = 'inicialAdmin'),
    #CABAÑA
    path('listarCabaña', login_required(ListarCabañas.as_view()), name = 'listarCabaña'),
    path('regitrarCab', login_required(RegistrarCabaña.as_view()), name = 'registrarCab'),
    path('editarCab<int:pk>', login_required(EditarCabaña.as_view()), name = 'editarCab'),
    path('deshabilitarCab/<int:pk>',DeshabilitarCab, name='deshabilitarCab'),
    path('habilitarCab/<int:pk>',HabilitarCab, name='habilitarCab'),
    #RANGO
    path('regitrarRango/<int:cabpk>', login_required(ListarRango.as_view()), name = 'registrarRango'),
    path('editarRango/<int:pk>', login_required(EditarRango.as_view()), name = 'editarRango'),
    path('eliminarRango/<int:pk>',EliminarRango, name='eliminarRango'),
    path('regitrarFoto/<int:cabpk>', login_required(RegistrarFoto.as_view()), name = 'registrarFoto'),
    
    #INSTALACIONES
    path('listarInstalacion', login_required(ListarInstalaciones.as_view()), name = 'listarInstalacion'),
    path('registrarInstalacion', login_required(RegistrarInstalacion.as_view()), name = 'registrarInstalacion'),
    path('editarInstlacion<int:pk>', login_required(EditarInstalacion.as_view()), name = 'editarInstalacion'),
    path('bajaInstalacion/<int:pk>',BajaInstalacion, name='bajaInstalacion'),
    #SERVICIOS
    path('listarServicio', login_required(ListarServicios.as_view()), name = 'listarServicio'),
    path('registrarServicio', login_required(RegistrarServicio.as_view()), name = 'registrarServicio'),
    path('editarServicio<int:pk>', login_required(EditarServicio.as_view()), name = 'editarServicio'),
    path('bajaServicio/<int:pk>',BajaServicio, name='bajaServicio'),
    #PROMOCION
    path('listarPromo', login_required(ListarPromo.as_view()), name = 'listarPromo'),
    path('registrarPromo', login_required(RegistrarPromo.as_view()), name = 'registrarPromo'),
    path('editarPromo<int:pk>', login_required(EditarPromo.as_view()), name = 'editarPromo'),
    path('bajaPromo/<int:pk>',BajaPromo, name='bajaPromo'),
    path('finPromo/<int:pk>',FinalizarPromo, name='finPromo'),
    #HUESPED
    path('listarHuesped', login_required(ListarHuesped.as_view()), name = 'listarHuesped'),
    path('registrarHuesped', login_required(RegistrarHuesped.as_view()), name = 'registrarHuesped'),
    path('editarHuesped<int:pk>', login_required(EditarHuesped.as_view()), name = 'editarHuesped'),
    path('bajaHuesped/<int:pk>',BajaHuesped, name='bajaHuesped'),

]
