from multiprocessing import context
from django.http import HttpResponse, HttpResponseRedirect
from django.shortcuts import render
from django.views import View, generic
from django.urls import reverse
from inquilinos.models import Reserva, Cab, Foto, Estado
from inquilinos.forms import RegResForm

# Views


class IndexView(View):
    def get(self, request):
        # cabs = [cab.slug for cab in Cab.objects.all()]
        cabs = Cab.objects.all()
        fotos = [f for f in Foto.objects.all()]
        ctx = {
            "cabs": cabs,
            "fotos": fotos,
        }
        return render(request, "inquilinos/index.html", ctx)


# class ReservaView(generic.DetailView):
#     model = Reserva
#     template_name = 'registrar_reserva.html'


class CabDetailView(generic.DetailView):
    model = Cab
    template_name = "inquilinos/cab_detail.html"


class RegistroReservaView(View):
    model = Reserva
    template_name = "inquilinos/reg_res.html"
    form_class = RegResForm

    def get(self, request, slug):
        form = self.form_class()
        context = {
            "form": form,
        }

        return render(request, self.template_name, context)

    def post(self, request, slug):
        form = self.form_class(request.POST)
        context = {
            "form": form,
        }
        if form.is_valid():
            nueva_reserva = Reserva(
                fechaDesde=form.cleaned_data["fechaDesdeHasta"][0],
                fechaHasta=form.cleaned_data["fechaDesdeHasta"][1],
                cantAdultos=form.cleaned_data["cantAdultos"],
                cab=Cab.objects.get(slug=slug),
                estado=Estado.objects.get(nombre="Pte Confirmacion"),
            )
            nueva_reserva.save()
            print(form.cleaned_data["cantAdultos"])
            return HttpResponseRedirect(reverse("inquilinos:index"))
        return render(request, self.template_name, context)
