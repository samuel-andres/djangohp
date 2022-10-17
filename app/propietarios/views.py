from django.http import HttpResponse
from django.shortcuts import render
from django.views import View, generic
from django.views.generic import TemplateView , CreateView , UpdateView ,DeleteView , ListView
from django.urls import reverse_lazy
from propietarios.forms import *
from inquilinos.models import Cab, Huesped, Reserva , Rango,Foto , Instalacion
from propietarios.models import Servicio, Promocion
import datetime
from inquilinos.utils import CustomParser

# from inquilinos.models import Reserva, Cabaña

# Views

CREAR_RANGO='propietarios:registrarRango'
CREAR_FOTO='propietarios:registrarFoto'
INICIO= 'propietarios:inicialAdmin'
LISTAR_INST= 'propietarios:listarInstalacion'
LISTAR_SERVICIO='propietarios:listarServicio'
LISTAR_CAB='propietarios:listarCabaña'
LISTAR_RANGO='propietarios:registrarRango'

#PANTALLAS GENERALES
class IndexView(View):
    # def get(self, request):
    # return render(request, 'cabañas/index.html')
    pass

class InicioAdmin(TemplateView):
    template_name = 'propietarios/inicialAdmin.html'

#CABAÑA
class RegistrarCabaña(CreateView):
    model=Cab
    form_class= RegCabForm
    template_name= 'propietarios/cabañas/registrarCab.html'
    context_object_name = 'propietarios'
    #success_url = reverse_lazy('AdmProyectos:crearNodo')

    def get_context_data(self, **kwargs):
        kwargs['cabaña'] = Cab.objects.all()
        kwargs['boton'] = 'Registrar'
        kwargs['titulo'] = 'Registrar Cabaña'
        return super(RegistrarCabaña,self).get_context_data(**kwargs)
    

    def form_valid(self, form) :
        form.instance.usuario = self.request.user
        return super().form_valid(form)
    
    def post(self, request, *args, **kwargs):
        if request.method == 'POST':
            print('request.POST create: ', request.POST)
            form = RegCabForm(request.POST, request.FILES)
            cabaña = form.save(commit=False)
            cabaña.usuario = request.user

            cabaña.save()
            
            self.kwargs['cabpk'] = cabaña.id
            
            return super().form_valid(form)

    def get_success_url(self):
        return reverse_lazy(LISTAR_CAB)

class EditarCabaña(UpdateView):
    model = Cab
    form_class = RegCabForm
    template_name= 'propietarios/cabañas/registrarCab.html'
    success_url = reverse_lazy('propietarios:listarCabaña')

    def get_context_data(self, **kwargs):
        kwargs['boton'] = 'Modificar'
        kwargs['titulo'] = 'Editar Cabaña'
        return super(EditarCabaña,self).get_context_data(**kwargs)

class ListarCabañas(ListView):
    model = Cab
    template_name = 'propietarios/cabañas/listarCabañas.html'
    context_object_name = 'propietarios'
    queryset = Cab.objects.all()
    def get_context_data(self, **kwargs):
        kwargs['cabaña'] = Cab.objects.all()
        kwargs['titulo'] = 'Listado de Cabañas'
        return super(ListarCabañas,self).get_context_data(**kwargs)

def DeshabilitarCab(request,pk):

    template_name ='propietarios/inicialAdmin.html'
    cab=Cab.objects.filter(id=pk)
    for item in cab: 
        item.habilitada = False
        item.save()
    return render (request, template_name)

def HabilitarCab(request,pk):

    template_name ='propietarios/inicialAdmin.html'
    cab=Cab.objects.filter(id=pk)
    for item in cab: 
        item.habilitada = True
        item.save()
    return render (request, template_name)

#RANGO
class ListarRango(CreateView):
    model=Rango
    form_class= RegRangoForm
    template_name= 'propietarios/rango/registrarRango.html'
    context_object_name = 'propietarios'

    def get_context_data(self, **kwargs):
        kwargs['rango'] = Rango.objects.filter(cab=self.kwargs['cabpk'])
        kwargs['boton'] = 'Registrar'
        kwargs['titulo'] = 'Registrar Rango'
        return super(ListarRango,self).get_context_data(**kwargs)
    

    def form_valid(self, form) :
        form.instance.usuario = self.request.user
        form.instance.cab = Cab.objects.get(id=self.kwargs['cabpk'])
        return super().form_valid(form)

    def post(self, request, *args, **kwargs):
        if request.method == 'POST':
            form = RegRangoForm(request.POST)
            form.instance.cab = Cab.objects.get(id=self.kwargs['cabpk'])
            rango = form.save(commit=False)
            rango.usuario = request.user
            rango.save()

        return super().form_valid(form)

    def get_success_url(self):
        return reverse_lazy(LISTAR_RANGO, args=[self.kwargs['cabpk']])

class EditarRango(UpdateView):
    model = Rango
    form_class = RegRangoForm
    template_name= 'propietarios/rango/editarRango.html'

    def get_context_data(self, **kwargs):
        kwargs['cabpk'] = Rango.objects.get(id=self.kwargs['pk']).cab.id
        kwargs['cabaña'] = Cab.objects.get(id=kwargs['cabpk'])
        kwargs['boton'] = 'Modificar'
        kwargs['titulo'] = 'Editar Rango'
        return super(EditarRango,self).get_context_data(**kwargs)

    def get_success_url(self):
        self.kwargs['rango'] = Rango.objects.get(id=self.kwargs['pk'])
        self.kwargs['cabpk'] = Cab.objects.get(id=self.kwargs['rango'].cab.id).id
        return reverse_lazy(CREAR_RANGO, args=[self.kwargs['cabpk']])

def EliminarRango(request,pk):
    template_name ='propietarios/inicialAdmin.html'
    rango=Rango.objects.filter(id=pk)
    rango.delete()  
    return render (request, template_name)

#FOTO
class RegistrarFoto(CreateView):
    model=Foto
    form_class= RegFotoForm
    template_name= 'propietarios/cabañas/registrarFoto.html'
    context_object_name = 'propietarios'
    #success_url = reverse_lazy('AdmProyectos:crearNodo')

    def get_context_data(self, **kwargs):
        kwargs['Foto'] = Foto.objects.filter(cab=self.kwargs['cabpk'])
        kwargs['boton'] = 'Regitrar'
        kwargs['titulo'] = 'Regitrar Foto'
        return super(RegistrarFoto,self).get_context_data(**kwargs)
    

    def form_valid(self, form) :
        form.instance.usuario = self.request.user
        form.instance.cab = Cab.objects.get(id=self.kwargs['cabpk'])
        return super().form_valid(form)

    def post(self, request, *args, **kwargs):
        if request.method == 'POST':
            form = RegFotoForm(request.POST, request.FILES)
            form.instance.cab = Cab.objects.get(id=self.kwargs['cabpk'])
            if form.is_valid():
                form.save()
                message = "Image uploaded succesfully!"

        return super().form_valid(form)

    def get_success_url(self):
        return reverse_lazy(INICIO)


#INSTALACIONES
class ListarInstalaciones(ListView):
    model = Instalacion
    template_name = 'propietarios/instalacion/listarInst.html'
    context_object_name = 'propietarios'
    queryset = Instalacion.objects.all()
    def get_context_data(self, **kwargs):
        kwargs['inst'] = Instalacion.objects.all()
        kwargs['titulo'] = 'Listado de Instalaciones'
        return super(ListarInstalaciones,self).get_context_data(**kwargs)

class RegistrarInstalacion(CreateView):
    model=Instalacion
    form_class= RegInstalacionForm
    template_name= 'propietarios/instalacion/registrarInst.html'
    context_object_name = 'propietarios'

    def get_context_data(self, **kwargs):
        kwargs['instalacion'] = Instalacion.objects.all()
        kwargs['boton'] = 'Registrar'
        kwargs['titulo'] = 'Regitrar Instalación'
        return super(RegistrarInstalacion,self).get_context_data(**kwargs)
    

    def form_valid(self, form) :
        form.instance.usuario = self.request.user
        return super().form_valid(form)

    def post(self, request, *args, **kwargs):
        if request.method == 'POST':
            form = RegInstalacionForm(request.POST)
            inst = form.save(commit=False)
            inst.usuario = request.user
            inst.save()

            self.kwargs['instpk'] = inst.id

        return super().form_valid(form)

    def get_success_url(self):
        return reverse_lazy(INICIO)

class EditarInstalacion(UpdateView):
    model = Instalacion
    form_class = RegInstalacionForm
    template_name= 'propietarios/instalacion/registrarInst.html'
    success_url = reverse_lazy('propietarios:listarInstalacion')

    def get_context_data(self, **kwargs):
        kwargs['boton'] = 'Modificar'
        kwargs['titulo'] = 'Editar Instalación'
        return super(EditarInstalacion,self).get_context_data(**kwargs)

def BajaInstalacion(request,pk):

    template_name ='propietarios/inicialAdmin.html'
    inst=Instalacion.objects.filter(id=pk)
    for item in inst: 
        item.baja = True
        item.save()
    return render (request, template_name)

#SERVICIOS
class ListarServicios(ListView):
    model = Servicio
    template_name = 'propietarios/servicios/listarServicios.html'
    context_object_name = 'propietarios'
    queryset = Servicio.objects.all()
    def get_context_data(self, **kwargs):
        kwargs['servicio'] = Servicio.objects.all()
        kwargs['titulo'] = 'Listado de Servicios'
        return super(ListarServicios,self).get_context_data(**kwargs)

class RegistrarServicio(CreateView):
    model=Servicio
    form_class= RegServiciosForm
    template_name= 'propietarios/servicios/crearServicio.html'
    context_object_name = 'propietarios'

    def get_context_data(self, **kwargs):
        kwargs['servicio'] = Servicio.objects.all()
        kwargs['boton'] = 'Registrar'
        kwargs['titulo'] = 'Regitrar Servicio'
        return super(RegistrarServicio,self).get_context_data(**kwargs)
    

    def form_valid(self, form) :
        form.instance.usuario = self.request.user
        return super().form_valid(form)

    def post(self, request, *args, **kwargs):
        if request.method == 'POST':
            form = RegServiciosForm(request.POST)
            inst = form.save(commit=False)
            inst.usuario = request.user
            inst.save()

            self.kwargs['serviciopk'] = inst.id

        return super().form_valid(form)

    def get_success_url(self):
        return reverse_lazy(LISTAR_SERVICIO)

class EditarServicio(UpdateView):
    model = Servicio
    form_class = RegServiciosForm
    template_name= 'propietarios/servicios/crearServicio.html'
    success_url = reverse_lazy('propietarios:listarServicio')

    def get_context_data(self, **kwargs):
        kwargs['boton'] = 'Modificar'
        kwargs['titulo'] = 'Editar Servicio'
        return super(EditarServicio,self).get_context_data(**kwargs)

def BajaServicio(request,pk):

    template_name ='propietarios/inicialAdmin.html'
    servicio=Servicio.objects.filter(id=pk)
    for item in servicio: 
        item.baja = True
        item.save()
    return render (request, template_name)

#PROMOCIONES
class ListarPromo(ListView):
    model = Promocion
    template_name = 'propietarios/promociones/verPromo.html'
    context_object_name = 'propietarios'
    queryset = Promocion.objects.all()
    def get_context_data(self, **kwargs):
        kwargs['promo'] = Promocion.objects.all()
        kwargs['titulo'] = 'Listado de Promociones'
        kwargs['fechaHoy'] = datetime.date.today()
        return super(ListarPromo,self).get_context_data(**kwargs)

class RegistrarPromo(CreateView):
    model=Promocion
    form_class= RegPromoForm
    template_name= 'propietarios/promociones/crearPromo.html'
    context_object_name = 'propietarios'

    def get_context_data(self, **kwargs):
        kwargs['servicio'] = Servicio.objects.all()
        kwargs['boton'] = 'Registrar'
        kwargs['titulo'] = 'Registrar Promoción'
        return super(RegistrarPromo,self).get_context_data(**kwargs)
    

    def form_valid(self, form) :
        form.instance.usuario = self.request.user
        return super().form_valid(form)

    def post(self, request, *args, **kwargs):
        if request.method == 'POST':
            form = RegPromoForm(request.POST)
            promo = form.save(commit=False)
            promo.usuario = request.user
            promo.save()

            self.kwargs['promopk'] = promo.id

        return super().form_valid(form)

    def get_success_url(self):
        return reverse_lazy('propietarios:listarPromo')

class EditarPromo(UpdateView):
    model = Promocion
    form_class = RegPromoForm
    template_name= 'propietarios/promociones/crearPromo.html'
    success_url = reverse_lazy('propietarios:listarPromo')

    def get_context_data(self, **kwargs):
        kwargs['boton'] = 'Modificar'
        kwargs['titulo'] = 'Editar Promoción'
        return super(EditarPromo,self).get_context_data(**kwargs)

def BajaPromo(request,pk):

    template_name ='propietarios/inicialAdmin.html'
    promo=Promocion.objects.filter(id=pk)
    for item in promo: 
        item.baja = True
        item.save()
    return render (request, template_name)

def FinalizarPromo(request,pk):
    template_name ='propietarios/inicialAdmin.html'
    promo=Promocion.objects.filter(id=pk)
    for item in promo: 
        item.fechaFin = datetime.date.today()
        item.save()
    
    return render (request, template_name)
    
#HUESPEDES
class ListarHuesped(ListView):
    model = Huesped
    template_name = 'propietarios/huesped/listarHuesped.html'
    context_object_name = 'propietarios'
    queryset = Huesped.objects.all()
    def get_context_data(self, **kwargs):
        kwargs['huesped'] = Huesped.objects.all()
        kwargs['titulo'] = 'Listado de Huespedes'
        return super(ListarHuesped,self).get_context_data(**kwargs)

class RegistrarHuesped(CreateView):
    model=Huesped
    form_class= RegHuespedForm
    template_name= 'propietarios/huesped/registrarHuesped.html'
    context_object_name = 'propietarios'

    def get_context_data(self, **kwargs):
        kwargs['huesped'] = Huesped.objects.all()
        kwargs['boton'] = 'Registrar'
        kwargs['titulo'] = 'Registrar Huesped'
        return super(RegistrarHuesped,self).get_context_data(**kwargs)
    

    def form_valid(self, form) :
        form.instance.usuario = self.request.user
        return super().form_valid(form)

    def post(self, request, *args, **kwargs):
        if request.method == 'POST':
            form = RegHuespedForm(request.POST)
            huesped = form.save(commit=False)
            huesped.usuario = request.user
            huesped.save()

            self.kwargs['huespedpk'] = huesped.id

        return super().form_valid(form)

    def get_success_url(self):
        return reverse_lazy('propietarios:listarHuesped')

class EditarHuesped(UpdateView):
    model = Huesped
    form_class = RegHuespedForm
    template_name= 'propietarios/huesped/registrarHuesped.html'
    success_url = reverse_lazy('propietarios:listarHuesped')

    def get_context_data(self, **kwargs):
        kwargs['boton'] = 'Modificar'
        kwargs['titulo'] = 'Editar Huesped'
        return super(EditarHuesped,self).get_context_data(**kwargs)

def BajaHuesped(request,pk):

    template_name ='propietarios/inicialAdmin.html'
    huesped=Huesped.objects.filter(id=pk)
    for item in huesped: 
        item.baja = True
        item.save()
    return render (request, template_name)