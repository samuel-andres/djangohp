import datetime

from django.contrib.auth.mixins import LoginRequiredMixin, PermissionRequiredMixin
from django.contrib.messages.views import SuccessMessageMixin
from django.core.mail import EmailMultiAlternatives, send_mail
from django.http import HttpResponse, HttpResponseRedirect
from django.shortcuts import render
from django.template.loader import render_to_string
from django.urls import reverse
from django.utils.html import strip_tags
from django.views import View, generic

from inquilinos.forms import CrearHuespedForm, RegResForm
from inquilinos.models import Cab, CambioEstado, Estado, Huesped, Rango, Reserva
from inquilinos.parsers import CustomParser

from .user import HuespedOwnerDetailView, HuespedOwnerListView, UserCreateView


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


class RegistroReservaView(PermissionRequiredMixin, View):
    """Vista de registro de reserva que utiliza un formulario custom y sobreescribe
    los métodos get y post de la vista abstracta para devolver el formulario con
    los datos cargados en caso de que el formulario sea inválido y guarda el contenido
    del DateRangePicker en dos campos distintos del modelo reserva en caso de que los
    datos sean correctos."""

    permission_required = ("inquilinos.puede_registrar_reserva",)

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
        reservas = (
            cab.reserva_set.all()
        )  # habría que ver si conviene pasar solo las que son > hoy
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
                cab=cab,
                huesped=request.user.huesped,
                # se calcula el precio final en el back por seguridad
                precioFinal=(cantNoches * cab.costoPorNoche),
            )
            # se guarda la reserva en la db
            nueva_reserva.save()
            # el estado se setea en pte confirmación
            cambioEstado = CambioEstado(
                estado=Estado.objects.get(nombre="Pte Confirmacion"),
                reserva=nueva_reserva,
            )
            cambioEstado.save()

            # se define el template a utilizar para el mail y se pasa en el contexto  la nueva reserva
            html_content = render_to_string(
                "inquilinos/email_res_reg.html",
                {
                    "reserva": nueva_reserva,
                },
            )
            # se eliminan las etiquetas
            text_content = strip_tags(html_content)

            # se constrye el mail
            email = EmailMultiAlternatives(
                subject=f"Nueva Reserva Registrada #{nueva_reserva.pk}",  # asunto
                body=text_content,
                from_email=None,  # acá lo dejé en none para que se use el host definido en settings.py
                to=[
                    "samuel5848@gmail.com"
                ],  # para, acá iria el mail de enc de reservas
            )

            # se define el tipo de representación del mail como text/html
            email.attach_alternative(html_content, "text/html")
            # se envía el mail al encargado de reservas
            email.send()

            # después del post exitoso se redirige a la vista detalle de la reserva
            return HttpResponseRedirect(
                reverse(
                    "inquilinos:res-det",
                    kwargs={
                        "pk": nueva_reserva.pk,
                    },
                )
            )
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
            "costoPorNoche": costoPorNoche,
        }
        return render(request, self.template_name, context)


class CrearPerfilHuespedView(SuccessMessageMixin, UserCreateView):
    """CreateView que hereda de la vista UserCreateView"""

    model = Huesped
    form_class = CrearHuespedForm
    success_message = "Datos cargados con éxito. Ya puedes realizar reservas!"


class PerfilHuespedDetailView(generic.DetailView):
    """DetailView del perfil del huesped"""

    model = Huesped


class ReservaDetailView(HuespedOwnerDetailView):
    """DetailView del perfil del huesped que hereda de HuespedOwnerDetailView"""

    model = Reserva


class ReservasDeHuespedListView(HuespedOwnerListView):
    """ListView de las reservas de un huesped que hereda de HuespedOwnerListView"""

    model = Reserva
    template_name = "inquilinos/reserva_h_list.html"
