import datetime

from crispy_forms.bootstrap import AppendedText, FormActions, PrependedText
from crispy_forms.helper import FormHelper
from crispy_forms.layout import HTML, Div, Field, Fieldset, Layout, Submit
from django import forms
from django.utils.translation import gettext_lazy as _

from inquilinos.models import Cab, Huesped, Rango

from .utils import CustomParser


class RegResForm(forms.Form):
    foo_slug = forms.SlugField()
    # cantidades predefinidas para los campos adultos y menores
    cant_choices = [
        (0, "0"),
        (1, "1"),
        (2, "2"),
        (3, "3"),
        (4, "4"),
        (5, "5"),
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
        try:
            desde, hasta = CustomParser.parsePickerInput(data)
        except:
            raise forms.ValidationError("Error. El formato correcto es DD/MM/AAAA")
        if desde > hasta:
            raise forms.ValidationError(
                "Error. La fecha de inicio debe ser <= a la fecha fin."
            )
        if desde.date() < datetime.date.today():
            print(desde)
            print(datetime.date.today())
            raise forms.ValidationError(
                "Error. La fecha ingresada debe ser >= a la fecha actual."
            )
        if hasta.date() == datetime.date.today():
            raise forms.ValidationError("Error. Debe alojarse al menos una noche.")
        cab = Cab.objects.get(slug=self.cleaned_data["foo_slug"])
        desde = desde.date()
        hasta = hasta.date()
        foobar = False
        for rango in cab.rango_set.filter(fechaHasta__gt=datetime.date.today()):
            foo = 0
            bar = 0
            if rango.fechaDesde <= desde <= rango.fechaHasta:
                foo = 1
            if rango.fechaDesde <= hasta <= rango.fechaHasta:
                bar = 1
            if foo >= 1 and bar >= 1:
                foobar = True
                break
            else:
                continue
        if not foobar:
            raise forms.ValidationError(
                "Alguna fecha en el rango ingresado no está habilitada."
            )

        for reserva in cab.get_reservas_abiertas():
            if reserva.fechaDesde <= desde <= reserva.fechaHasta:
                raise forms.ValidationError(
                    "Alguna fecha en el rango ingresado no está habilitada"
                )
            if reserva.fechaDesde <= hasta <= reserva.fechaHasta:
                raise forms.ValidationError(
                    "Alguna fecha en el rango ingresado no está habilitada"
                )
            if desde <= reserva.fechaDesde <= hasta:
                raise forms.ValidationError(
                    "Alguna fecha en el rango ingresado no está habilitada"
                )
            if desde <= reserva.fechaHasta <= hasta:
                raise forms.ValidationError(
                    "Alguna fecha en el rango ingresado no está habilitada"
                )

        return data

    def clean(self):
        cleaned_data = super().clean()
        cantMenores = cleaned_data.get("cantMenores")
        cantAdultos = cleaned_data.get("cantAdultos")
        # si la cantidad de menores seleccionada es mayor a 0
        # (el if verifica que solo se realice la validación si los
        # dos campos que dependen de sí pasaron sus propias validaciones)
        if cantMenores and cantAdultos:
            # se valida que la suma de menores y mayores sea menor a 5
            if (int(cantAdultos) + int(cantMenores)) > 5:
                raise forms.ValidationError("Máxima cantidad de personas = 5")

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.helper = FormHelper()
        self.helper.layout = Layout(
            Fieldset(
                "Reservar cabaña",
                Field("fechaDesdeHasta", css_class="mb-3 form-control"),
                Field("cantAdultos", css_class="mb-3 form-control text-center"),
                Field("cantMenores", css_class="mb-3 form-control text-center"),
                Div(
                    HTML(
                        """
                        <p id="ptag"></p>
                        """
                    ),
                    css_id="after_reserva",
                ),
                "foo_slug",
            ),
            Submit("submit", "Confirmar", css_class="btn btn-primary cuac"),
            HTML('<a class="btn btn-secondary" href="/">Cancelar</a>'),
        )
        self.helper.form_method = "POST"
        self.helper.form_style = "inline"
        self.fields["foo_slug"].widget = forms.HiddenInput()


class CrearHuespedForm(forms.ModelForm):
    class Meta:
        model = Huesped
        fields = [
            "nombre",
            "apellido",
            "telefono",
        ]

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.helper = FormHelper()
        self.helper.layout = Layout(
            Fieldset(
                "Cargar datos personales",
                Field("nombre", css_class="mb-3 form-control"),
                Field("apellido", css_class="mb-3 form-control"),
                Field("telefono", css_class="mb-3 form-control"),
            ),
            Submit("submit", "Confirmar", css_class="btn btn-primary cuac"),
            HTML('<a class="btn btn-secondary" href="/">Cancelar</a>'),
        )
        self.helper.form_method = "POST"
        self.helper.form_style = "inline"
