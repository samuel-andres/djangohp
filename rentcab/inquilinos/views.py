from django.contrib.auth.mixins import PermissionRequiredMixin, LoginRequiredMixin
from django.contrib.messages.views import SuccessMessageMixin
from django.core.exceptions import PermissionDenied
from django.http import HttpResponseRedirect
from django.shortcuts import get_object_or_404, render
from django.views import View, generic

from inquilinos.forms import (
    CrearHuespedForm,
    RegResForm,
    ComentarioCreateForm,
    CancelarReservaForm,
)
from inquilinos.models import Cab, Huesped, Reserva, Comentario
from inquilinos.utils import CustomParser

from .restricted import (
    HuespedRestrictedListView,
    UserRestrictedCreateView,
    HuespedRestrictedCreateView,
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

    def get_context_data(self, **kwargs):
        context = super(CabDetailView, self).get_context_data(**kwargs)
        context["comentarios"] = (
            self.get_object().comentarios.all().order_by("-id")[:12]
        )
        return context


class RegistroReservaView(PermissionRequiredMixin, View):
    """
    Vista de registro de reserva que utiliza un formulario custom y sobreescribe
    los métodos get y post de la vista abstracta para devolver el formulario con
    los datos cargados en caso de que el formulario sea inválido y guarda el contenido
    del DateRangePicker en dos campos distintos del modelo reserva en caso de que los
    datos sean correctos.
    """

    permission_required = ("inquilinos.puede_registrar_reserva",)
    permission_denied_message = "Para consultar la disponibilidad de las cabañas y registrar reservas debes completar tus datos personales."
    model = Reserva
    template_name = "inquilinos/registro_reserva.html"
    form_class = RegResForm

    def get(self, request, slug):
        # se genera el formulario vacío
        form = self.form_class(initial={"cab_slug": slug})
        # se obtiene la cabaña actual
        cab = get_object_or_404(Cab, slug=slug)
        costoPorAdulto = cab.costoPorAdulto
        costoPorMenor = cab.costoPorMenor
        cantMaxPersonas = cab.cantMaxPersonas
        # se obtienen las fechas en que la cabaña está habilitada y deshabilitada
        fechasHabilitadas, fechasDeshabilitadas = cab.get_fechas_hab_y_des()
        # se pasa como contexto el formulario vacío, el día de hoy y las fechas habilitadas y deshabilitadas
        context = {
            "form": form,
            "fechasHabilitadas": fechasHabilitadas,
            "fechasDeshabilitadas": fechasDeshabilitadas,
            "costoPorAdulto": costoPorAdulto,
            "costoPorMenor": costoPorMenor,
            "cantMaxPersonas": cantMaxPersonas,
        }

        return render(request, self.template_name, context)

    def post(self, request, slug):
        # guarda el formulario con los datos ingresados
        form = self.form_class(request.POST, initial={"cab_slug": slug})
        if form.is_valid():
            # si el formulario es válido parseo las fechas del datepicker
            # y las convierto a objetos datetime
            pickerinput = form.cleaned_data["fechaDesdeHasta"]
            fechaDesde, fechaHasta = self.parse_picker_input(pickerinput=pickerinput)
            # obtengo la cabaña según el slug del url
            cab = get_object_or_404(Cab, slug=slug)
            # genero la payload para la carga
            datos_reserva = {
                "fechaDesde": fechaDesde,
                "fechaHasta": fechaHasta,
                "cantAdultos": form.cleaned_data["cantAdultos"],
                "cantMenores": form.cleaned_data["cantMenores"],
                "huesped": request.user.huesped,
            }
            # se delega la creación de la reserva al objeto cabaña con la payload correspondiente
            res = cab.crear_reserva(datos_reserva)

            # después del post exitoso se redirige a la vista detalle de la reserva
            return HttpResponseRedirect(
                reverse(
                    "inquilinos:reserva-detail",
                    kwargs={
                        "pk": res.pk,
                    },
                )
            )

        # si el formulario no fue válido se devuelve el formulario con los datos incorrectos
        cab = get_object_or_404(Cab, slug=slug)
        costoPorAdulto = cab.costoPorAdulto
        costoPorMenor = cab.costoPorMenor
        cantMaxPersonas = cab.cantMaxPersonas
        # se obtienen las fechas en que la cabaña está habilitada y deshabilitada
        fechasHabilitadas, fechasDeshabilitadas = cab.get_fechas_hab_y_des()
        context = {
            "form": form,
            "fechasHabilitadas": fechasHabilitadas,
            "fechasDeshabilitadas": fechasDeshabilitadas,
            "costoPorAdulto": costoPorAdulto,
            "costoPorMenor": costoPorMenor,
            "cantMaxPersonas": cantMaxPersonas,
        }
        return render(request, self.template_name, context)

    def parse_picker_input(self, pickerinput):
        """
        toma como entrada el valor validado del picker y devuelve dos
        objetos datetime
        """

        return CustomParser.parsePickerInput(pickerinput=pickerinput)


class HuespedCreateView(SuccessMessageMixin, UserRestrictedCreateView):
    """CreateView que hereda de la vista UserCreateView"""

    model = Huesped
    form_class = CrearHuespedForm
    success_message = "Datos cargados con éxito. Ya puedes realizar reservas!"


class HuespedDetailView(generic.DetailView):
    """DetailView del perfil del huesped"""

    model = Huesped


class HuespedUpdateView(LoginRequiredMixin, generic.UpdateView):
    """UpdateView para el perfil del huesped"""

    model = Huesped
    form_class = CrearHuespedForm

    def get_object(self, *args, **kwargs):
        return self.request.user.huesped


class ReservaDetailView(PermissionRequiredMixin, View):
    """DetailView de reserva. Un huesped solo tiene acceso a las reservas que
    registró."""

    permission_required = ("inquilinos.puede_registrar_reserva",)
    permission_denied_message = "Esta reserva no te pertenece."
    model = Reserva

    def get(self, request, pk):
        reserva = get_object_or_404(Reserva, pk=pk)
        if reserva.huesped != request.user.huesped:
            raise PermissionDenied(self.permission_denied_message)
        context = {
            "reserva": reserva,
            "estadoreserva": reserva.get_estado().nombre,
        }
        return render(request, "inquilinos/reserva_detail.html", context)


class ReservasListView(HuespedRestrictedListView):
    """ListView de las reservas de un huesped que hereda de HuespedRestrictedListView"""

    model = Reserva
    template_name = "inquilinos/reservas_list.html"


class ComentarioCreateView(HuespedRestrictedCreateView):
    """CreateView de comentario"""

    model = Comentario
    template_name = "inquilinos/registrar_comentario.html"
    form_class = ComentarioCreateForm

    def get(self, request, *args, **kwargs):
        reserva = Reserva.objects.get(id=self.kwargs["pk"])
        if not reserva.se_puede_calificar():
            return HttpResponseRedirect(
                reverse(
                    "inquilinos:reserva-detail",
                    kwargs={
                        "pk": reserva.pk,
                    },
                )
            )
        return super().get(request, *args, **kwargs)

    def form_valid(self, form):
        reserva = Reserva.objects.get(id=self.kwargs["pk"])
        object = form.save(commit=False)
        object.huesped = self.request.user.huesped
        object.reserva = reserva
        object.cab = reserva.cab
        object.save()
        return super(ComentarioCreateView, self).form_valid(form)


class CancelarReservaView(PermissionRequiredMixin, View):
    """View para cancelar reservas con formulario que permite
    cargar un motivo de cancelacion asociado a la reserva"""

    model = Reserva
    form_class = CancelarReservaForm
    template_name = "inquilinos/cancelar_reserva.html"
    permission_required = ("inquilinos.puede_registrar_reserva",)

    def get(self, request, pk):
        reserva = get_object_or_404(Reserva, pk=pk)
        if not reserva.se_puede_cancelar():
            return HttpResponseRedirect(
                reverse(
                    "inquilinos:reserva-detail",
                    kwargs={
                        "pk": reserva.pk,
                    },
                )
            )
        form = self.form_class()
        context = {"form": form}
        return render(request, self.template_name, context)

    def post(self, request, pk):
        reserva = get_object_or_404(Reserva, pk=pk)
        if not reserva.se_puede_cancelar():
            return HttpResponseRedirect(
                reverse(
                    "inquilinos:reserva-detail",
                    kwargs={
                        "pk": reserva.pk,
                    },
                )
            )
        form = self.form_class(request.POST)
        if form.is_valid():
            reserva.set_motivo_cancelacion(form.cleaned_data.get("motivoCancelacion"))
            return HttpResponseRedirect(
                reverse(
                    "inquilinos:reserva-detail",
                    kwargs={
                        "pk": reserva.pk,
                    },
                )
            )
        context = {
            "form": form,
        }
        return render(request, self.template_name, context)
