import datetime
from email.policy import default

from crispy_forms.bootstrap import AppendedText, FormActions, PrependedText
from crispy_forms.helper import FormHelper
from crispy_forms.layout import HTML, Div, Field, Fieldset, Layout, Submit
from django import forms
from django.utils.translation import gettext_lazy as _

from inquilinos.models import Cab, Huesped, Rango, Comentario

from .utils import CustomParser


class RegResForm(forms.Form):
    foo_slug = forms.SlugField()
    # cantidades predefinidas para los campos adultos y menores
    # textinput con el id que usa el datepicker
    fechaDesdeHasta = forms.CharField(
        widget=forms.TextInput(
            attrs={
                "id": "litepicker",
                "placeholder": "Ingreso - Salida",
                "class":"mb-3 form-control textinput textInput text-center",
                "readonly":"true",
            }
        ),
        label="Rango de reserva",
    )
    # el [1:] es pq no puede haber 0 adultos
    # cantAdultos = forms.ChoiceField(
    #     choices=cant_choices[1:], label="Cantidad de adultos"
    # )
    cantAdultos = forms.IntegerField(
        max_value=5,
        min_value=1,
        # initial=1,
        widget=forms.TextInput(
            attrs={
                "class":"form-control text-center numberinput",
                'required':'true',
                "style":"border: 1px solid;",
                "readonly":"true",
            }
        ),
    )

    cantMenores = forms.IntegerField(
        max_value=5,
        min_value=1,
        # initial=1,
        widget=forms.TextInput(
            attrs={
                "class":"form-control text-center numberinput",
                'required':'true',
                "style":"border: 1px solid;",
                "readonly":"true",
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
    #     self.helper = FormHelper()
    #     self.helper.layout = Layout(
    #         Fieldset(
    #             "Reservar cabaña",
    #             Field("fechaDesdeHasta", css_class="mb-3 form-control"),
    #             Div(
    #                 Div(
    #                     Div(
    #                         Div(
    #                             HTML("""
    #                                 <button class="btn btn-outline-secondary" type="button" id="button-addon1">+</button>
    #                             """),
    #                             Field("cantAdultos", css_class="mb-3 form-control text-center"),
    #                             HTML("""
    #                                 <button class="btn btn-outline-secondary" type="button" id="button-addon1">+</button>
    #                             """),
    #                             css_class = "input-group mb-3 mt-1"
    #                         ),
    #                         css_class = "col-md-6"
    #                     ),
    #                     css_class = "row"
    #                 ),
    #             #     HTML(
    #             #         """
    #             #         <div class="input-group mb-3">
    #             #             <button class="btn btn-outline-secondary" type="button" id="button-addon1">+</button>
    #             #         </div>
    #             #         """
    #             #     ),
    #             #     Field("cantAdultos", css_class="mb-3 form-control text-center"),
    #             #     css_id="div_cantAdultos",
    #             #     css_class = "row",
    #             # ),
    #             Field("cantMenores", css_class="mb-3 form-control text-center"),
    #             Div(
    #                 HTML(
    #                     """
    #                     <p id="ptag"></p>
    #                     """
    #                 ),
    #                 css_id="after_reserva",
    #             ),
    #             "foo_slug",
    #         ),
    #         Submit("submit", "Confirmar", css_class="btn btn-primary cuac"),
    #         HTML('<a class="btn btn-secondary" href="/">Cancelar</a>'),
    #         ),
    #     )
    #     self.helper.form_method = "POST"
    #     self.helper.form_style = "inline"
        self.fields["foo_slug"].widget = forms.HiddenInput()
    #     self.fields['cantAdultos'].widget.attrs['readonly'] = True
    #     self.fields['cantAdultos'].label = False


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
