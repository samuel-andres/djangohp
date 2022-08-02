import datetime

from django.contrib.auth.mixins import PermissionRequiredMixin
from django.contrib.messages.views import SuccessMessageMixin
from django.http import HttpResponseRedirect
from django.shortcuts import render, get_object_or_404
from django.urls import reverse
from django.views import View, generic

from inquilinos.forms import CrearHuespedForm, RegResForm
from inquilinos.models import Cab, Huesped, Reserva
from inquilinos.utils import CustomParser

from .restricted import (
    HuespedRestrictedDetailView,
    HuespedRestrictedListView,
    UserRestrictedCreateView,
)


# Views
class IndexView(generic.ListView):
    """Vista del home que acepta get requests y renderiza el template index.html
    con las cabañas como contexto"""

    model = Cab
    template_name = "inquilinos/index.html"


class CabDetailView(generic.DetailView):
    """DetailView de Cabañas"""

    model = Cab
    template_name = "inquilinos/cab_detail.html"


class RegistroReservaView(PermissionRequiredMixin, View):
    """
    Vista de registro de reserva que utiliza un formulario custom y sobreescribe
    los métodos get y post de la vista abstracta para devolver el formulario con
    los datos cargados en caso de que el formulario sea inválido y guarda el contenido
    del DateRangePicker en dos campos distintos del modelo reserva en caso de que los
    datos sean correctos.
    """

    permission_required = ("inquilinos.puede_registrar_reserva",)

    model = Reserva
    template_name = "inquilinos/reg_res.html"
    form_class = RegResForm

    def get(self, request, slug):
        # se genera el formulario vacío
        form = self.form_class(initial={"foo_slug": slug})
        # se obtiene la cabaña actual
        cab = get_object_or_404(Cab, slug=slug)
        costoPorNoche = cab.costoPorNoche
        # se obtienen las fechas en que la cabaña está habilitada y deshabilitada
        fechas_habilitadas, fechas_deshabilitadas = cab.get_fechas_hab_y_des()
        today = self.parse_fecha_actual()
        # se pasa como contexto el formulario vacío, el día de hoy y las fechas habilitadas y deshabilitadas
        context = {
            "form": form,
            "today": today,
            "costoPorNoche": costoPorNoche,
            "allowed_dates": fechas_habilitadas,
            "disabled_dates": fechas_deshabilitadas,
        }

        return render(request, self.template_name, context)

    def post(self, request, slug):
        # guarda el formulario con los datos ingresados
        form = self.form_class(request.POST, initial={"foo_slug": slug})
        if form.is_valid():
            # si el formulario es válido parseo las fechas del datepicker
            # y las convierto a objetos datetime
            pickerinput = form.cleaned_data["fechaDesdeHasta"]
            fechaDesde, fechaHasta = self.parse_picker_input(pickerinput=pickerinput)
            # obtengo la cabaña según el slug del url
            cab = get_object_or_404(Cab, slug=slug)
            datos_reserva = {
                "fechaDesde": fechaDesde,
                "fechaHasta": fechaHasta,
                "cantAdultos": form.cleaned_data["cantAdultos"],
                "cantMenores": form.cleaned_data["cantMenores"],
                "huesped": request.user.huesped,
            }
            res = cab.crear_reserva(datos_reserva)

            # después del post exitoso se redirige a la vista detalle de la reserva
            return HttpResponseRedirect(
                reverse(
                    "inquilinos:res-det",
                    kwargs={
                        "pk": res.pk,
                    },
                )
            )
        # si el formulario no fue válido se devuelve el formulario con los datos incorrectos
        cab = get_object_or_404(Cab, slug=slug)
        costoPorNoche = cab.costoPorNoche
        # se obtienen las fechas en que la cabaña está habilitada y deshabilitada
        fechas_habilitadas, fechas_deshabilitadas = cab.get_fechas_hab_y_des()
        today = self.parse_fecha_actual()
        context = {
            "form": form,
            "today": today,
            "allowed_dates": fechas_habilitadas,
            "disabled_dates": fechas_deshabilitadas,
            "costoPorNoche": costoPorNoche,
        }
        return render(request, self.template_name, context)

    def parse_fecha_actual(self):
        """
        devuelve el día de hoy parseado en formato str mm/dd/YYYY
        """

        return CustomParser.getParsedToday()

    def parse_picker_input(self, pickerinput):
        """
        toma como entrada el valor clean del picker y devuelve dos
        objetos datetime
        """

        return CustomParser.parsePickerInput(pickerinput=pickerinput)


class CrearPerfilHuespedView(SuccessMessageMixin, UserRestrictedCreateView):
    """CreateView que hereda de la vista UserCreateView"""

    model = Huesped
    form_class = CrearHuespedForm
    success_message = "Datos cargados con éxito. Ya puedes realizar reservas!"


class PerfilHuespedDetailView(generic.DetailView):
    """DetailView del perfil del huesped"""

    model = Huesped


class ReservaDetailView(HuespedRestrictedDetailView):
    """DetailView del perfil del huesped que hereda de HuespedOwnerDetailView"""

    model = Reserva


class ReservasDeHuespedListView(HuespedRestrictedListView):
    """ListView de las reservas de un huesped que hereda de HuespedOwnerListView"""

    model = Reserva
    template_name = "inquilinos/reserva_h_list.html"
