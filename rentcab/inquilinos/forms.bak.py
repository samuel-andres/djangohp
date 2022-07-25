import datetime
from django import forms
from django.utils.translation import gettext_lazy as _
from crispy_forms.helper import FormHelper
from crispy_forms.layout import Submit, Layout, Field
from inquilinos.parsers import CustomParser
from inquilinos.models import Rango, Cab


class RegResForm(forms.Form):
    foo_slug = forms.SlugField(widget=forms.HiddenInput())
    # cantidades predefinidas para los campos adultos y menores
    cant_choices = [
        (0, "Cero"),
        (1, "Uno"),
        (2, "Dos"),
        (3, "Tres"),
        (4, "Cuatro"),
        (5, "Cinco"),
    ]
    # textinput con el id que usa el datepicker
    fechaDesdeHasta = forms.CharField(
        widget=forms.TextInput(
            attrs={
                "id": "litepicker",
                "placeholder": "Ingreso - Salida",
            }
        ),
        label="Rango de reserva",
    )
    # el [1:] es pq no puede haber 0 adultos
    cantAdultos = forms.ChoiceField(
        choices=cant_choices[1:], label="Cantidad de adultos"
    )
    cantMenores = forms.ChoiceField(
        choices=cant_choices,
        label="Cantidad de niños",
    )

    def clean_fechaDesdeHasta(self):
        # validación por si el usuario tipea a mano
        data = self.cleaned_data["fechaDesdeHasta"]
        myCustomParser = CustomParser()
        try:
            desde, hasta = myCustomParser.parsePickerInput(data)
        except:
            raise forms.ValidationError("Error. El formato correcto es DD/MM/AAAA")
        if desde > hasta:
            raise forms.ValidationError(
                "Error. La fecha de inicio debe ser <= a la fecha fin."
            )
        if desde < datetime.datetime.today():
            raise forms.ValidationError(
                "Error. La fecha ingresada debe ser >= a la fecha actual."
            )
        cab = Cab.objects.get(slug=self.cleaned_data["foo_slug"])
        desde = desde.date()
        hasta = hasta.date()
        foo = 0
        bar = 0
        for rango in cab.rango_set.all():
            if rango.fechaDesde <= desde <= rango.fechaHasta:
                foo = 1
            if rango.fechaDesde <= hasta <= rango.fechaHasta:
                bar = 1
            if foo >= 1 and bar >= 1:
                break
            else:
                raise forms.ValidationError(
                    "Alguna fecha en el rango ingresado no está habilitada"
                )

        for reserva in cab.reserva_set.all():
            if reserva.fechaDesde <= desde <= reserva.fechaHasta:
                raise forms.ValidationError(
                    "Alguna fecha en el rango ingresado no está habilitada"
                )
            if reserva.fechaDesde <= hasta <= reserva.fechaHasta:
                raise forms.ValidationError(
                    "Alguna fecha en el rango ingresado no está habilitada"
                )

        return data

    def clean_cantMenores(self):
        # sobreescribo la validación del campo cantidad de menores
        # primero se hace la validación por defecto
        cl_mens = self.cleaned_data["cantMenores"]
        cl_ads = self.cleaned_data["cantAdultos"]
        # si la cantidad de menores seleccionada es mayor a 0
        if int(cl_mens) > 0:
            # se valida que la suma de menores y mayores sea menor a 5
            if (int(cl_ads) + int(cl_mens)) > 5:
                raise forms.ValidationError("Máxima cantidad de personas = 5")
        # se devuelven los datos
        data = cl_mens
        return data

    # huesped = forms.ModelChoiceField(queryset=Estado.objects.filter(ambito='cab'))
    # form helper para agregar el boton de submit y definir el metodo post en el formulario
    helper = FormHelper()
    helper.add_input(Submit("submit", "Confirmar", css_class="btn-primary cuac"))
    helper.form_method = "POST"
    helper.form_style = "inline"
