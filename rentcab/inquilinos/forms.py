import datetime
from email.policy import default

from crispy_forms.bootstrap import AppendedText, FormActions, PrependedText
from crispy_forms.helper import FormHelper
from crispy_forms.layout import HTML, Div, Field, Fieldset, Layout, Submit
from django import forms
from django.utils.translation import gettext_lazy as _

from inquilinos.models import Cab, Huesped, Rango, Comentario, Reserva

from .utils import CustomParser


class RegResForm(forms.Form):
    """Formulario para el registro de reservas."""

    cab_slug = forms.SlugField()
    # cantidades predefinidas para los campos adultos y menores
    # textinput con el id que usa el datepicker
    fechaDesdeHasta = forms.CharField(
        widget=forms.TextInput(
            attrs={
                "id": "litepicker",
                "placeholder": "Ingreso - Salida",
                "class": "mb-3 form-control textinput textInput text-center",
                "readonly": "true",
            }
        ),
        label="Rango de reserva",
    )
    # el [1:] es pq no puede haber 0 adultos
    # cantAdultos = forms.ChoiceField(
    #     choices=cant_choices[1:], label="Cantidad de adultos"
    # )
    cantAdultos = forms.IntegerField(
        min_value=1,
        widget=forms.TextInput(
            attrs={
                "class": "form-control text-center numberinput",
                "required": "true",
                "style": "border: 1px solid #D3D3D3;",
                "readonly": "true",
            }
        ),
    )

    cantMenores = forms.IntegerField(
        min_value=0,
        widget=forms.TextInput(
            attrs={
                "class": "form-control text-center numberinput",
                "required": "true",
                "style": "border: 1px solid #D3D3D3;",
                "readonly": "true",
            }
        ),
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
            raise forms.ValidationError(
                "Error. La fecha ingresada debe ser >= a la fecha actual."
            )
        if hasta.date() == datetime.date.today():
            raise forms.ValidationError("Error. Debe alojarse al menos una noche.")
        cab = Cab.objects.get(slug=self.cleaned_data["cab_slug"])
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
        # (el if verifica que solo se realice la validación si los
        # dos campos que dependen de sí pasaron sus propias validaciones)
        if cantMenores and cantAdultos:
            cab = Cab.objects.get(slug=self.cleaned_data["cab_slug"])
            cantMaxPersonas = cab.cantMaxPersonas
            # se valida que la suma de menores y mayores sea menor a la maxima cantidad de personas definida en la cabaña
            if (int(cantAdultos) + int(cantMenores)) > cantMaxPersonas:
                raise forms.ValidationError(
                    f"Máxima cantidad de personas = {cantMaxPersonas}"
                )

    def __init__(self, *args, **kwargs):
        self.request = kwargs.pop("request", None)
        super().__init__(*args, **kwargs)
        self.fields["cab_slug"].widget = forms.HiddenInput()


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


class ComentarioCreateForm(forms.ModelForm):
    class Meta:
        model = Comentario
        fields = [
            "comentario",
            "calificacion",
        ]

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.helper = FormHelper()
        self.helper.layout = Layout(
            Fieldset(
                "Deja un comentario",
                Field("comentario", css_class="mb-3 form-control"),
                Field("calificacion", css_class="mb-3 form-control"),
            ),
            Submit("submit", "Confirmar", css_class="btn btn-primary cuac"),
            HTML('<a class="btn btn-secondary" href="/">Cancelar</a>'),
        )
        self.helper.form_method = "POST"
        self.helper.form_style = "inline"


class CancelarReservaForm(forms.ModelForm):
    class Meta:
        model = Reserva
        fields = ["motivoCancelacion"]

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields["motivoCancelacion"].widget = forms.Textarea(
            attrs={"class": "form-control"}
        )
        self.fields["motivoCancelacion"].required = True
