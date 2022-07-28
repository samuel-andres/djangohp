import datetime
from django.http import HttpResponse, HttpResponseRedirect
from django.shortcuts import render
from django.views import View, generic
from django.urls import reverse
from inquilinos.models import Reserva, Cab, Estado, Rango, Huesped
from inquilinos.forms import RegResForm, CrearHuespedForm
from inquilinos.parsers import CustomParser
from .user import UserCreateView
from django.contrib.auth.mixins import LoginRequiredMixin, PermissionRequiredMixin

# Views
class IndexView(View):
    """Vista del home que acepta get requests y renderiza el template index.htm
    con las cabañas como contexto"""

    def get(self, request):
        cabs = Cab.objects.all()
        ctx = {
            "cabs": cabs,
        }
        return render(request, "inquilinos/index.html", ctx)


class CabDetailView(generic.DetailView):
    """DetailView de Cabañas"""

    model = Cab
    template_name = "inquilinos/cab_detail.html"


class RegistroReservaView(PermissionRequiredMixin,View):
    """Vista de registro de reserva que utiliza un formulario custom y sobreescribe
    los métodos get y post de la vista abstracta para devolver el formulario con
    los datos cargados en caso de que el formulario sea inválido y guarda el contenido
    del DateRangePicker en dos campos distintos del modelo reserva en caso de que los
    datos sean correctos."""

    permission_required = (
        'inquilinos.puede_registrar_reserva',
    )

    model = Reserva
    # template_name = "inquilinos/reg_res.html"
    template_name = "inquilinos/reg_res.html"
    form_class = RegResForm

    def get(self, request, slug):
        # se genera el formulario vacío
        form = self.form_class(initial={"foo_slug": slug})
        # se obtiene la cabaña actual
        cab = Cab.objects.get(slug=slug)
        costoPorNoche = cab.costoPorNoche
        # se obtienen los rangos asociados a la cabaña
        ranges = Rango.objects.filter(cab_id=cab.id)
        # se obtienen las reservas asociadas a la cabaña
        reservas = cab.reserva_set.all() # habría que ver si conviene pasar solo las que son > hoy
        myCustomParser = CustomParser()
        allowed_dates = myCustomParser.parseRanges(ranges=ranges)
        disabled_dates = myCustomParser.parseReservas(reservas=reservas)
        today = myCustomParser.getParsedToday()
        # se pasa como contexto el formulario vacío, el día de hoy y las fechas habilitadas y deshabilitadas
        context = {
            "form": form,
            "today": today,
            "costoPorNoche": costoPorNoche,
            "allowed_dates": allowed_dates,
            "disabled_dates": disabled_dates,
        }

        return render(request, self.template_name, context)

    def post(self, request, slug):
        # guarda el formulario con los datos ingresados
        form = self.form_class(request.POST, initial={"foo_slug": slug})
        # context = {
        #     "form": form,
        # }
        if form.is_valid():
            # si el formulario es válido parseo las fechas del datepicker
            # y las convierto a objetos datetime
            pickerinput = form.cleaned_data["fechaDesdeHasta"]
            myCurstomParser = CustomParser()
            DesdeHastaTupla = myCurstomParser.parsePickerInput(pickerinput=pickerinput)
            date_object1, date_object2 = DesdeHastaTupla
            # obtengo la cabaña según el slug del url
            cab = Cab.objects.get(slug=slug)
            # calculo la cantidad de noches
            cantNoches = (date_object2 - date_object1).days
            # creo la reserva con los datos cargados por el usuario
            nueva_reserva = Reserva(
                fechaDesde=date_object1,
                fechaHasta=date_object2,
                cantAdultos=form.cleaned_data["cantAdultos"],
                cantMenores=form.cleaned_data["cantMenores"],
                # se setea la cabaña obtenida más arriba
                cab = cab,
                huesped = request.user.huesped,
                # se calcula el precio final en el back por seguridad
                precioFinal = (cantNoches * cab.costoPorNoche),
                # el estado se setea en pte confirmación
                estado=Estado.objects.get(nombre="Pte Confirmacion"),
            )
            # se guarda la reserva en la db
            nueva_reserva.save()
            # después del post exitoso se redirige al usuario al home
            return HttpResponseRedirect(reverse("inquilinos:index"))
        # si el formulario no fue válido se devuelve el formulario con los datos incorrectos
        cab = Cab.objects.get(slug=slug)
        ranges = Rango.objects.filter(cab_id=cab.id)
        reservas = cab.reserva_set.all()
        myCustomParser = CustomParser()
        allowed_dates = myCustomParser.parseRanges(ranges=ranges)
        disabled_dates = myCustomParser.parseReservas(reservas=reservas)
        today = myCustomParser.getParsedToday()
        costoPorNoche = cab.costoPorNoche
        context = {
            "form": form,
            "today": today,
            "allowed_dates": allowed_dates,
            "disabled_dates": disabled_dates,
            'costoPorNoche' : costoPorNoche,
        }
        return render(request, self.template_name, context)


class CrearPerfilHuespedView(UserCreateView):
    model = Huesped
    form_class = CrearHuespedForm

class PerfilHuespedDetailView(generic.DetailView):
    model = Huesped