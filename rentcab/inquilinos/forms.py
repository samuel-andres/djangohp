import datetime
from django import forms
from django.utils.translation import gettext_lazy as _
from crispy_forms.helper import FormHelper
from crispy_forms.layout import Submit, Layout, Field


class RegResForm(forms.Form):
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
        widget= forms.TextInput(
            attrs={
                'id':'litepicker'
                }
            ),
            label = 'Rango de reserva'
    )
    # el [1:] es pq no puede haber 0 adultos
    cantAdultos = forms.ChoiceField(
        choices=cant_choices[1:], label="Cantidad de adultos"
    )
    cantMenores = forms.ChoiceField(
        choices=cant_choices,
        label = 'Cantidad de niños',
    )   

    def clean_cantMenores(self):
        # sobreescribo la validación del campo cantidad de menores
        # primero se hace la validación por defecto
        cl_mens = self.cleaned_data['cantMenores']
        cl_ads = self.cleaned_data['cantAdultos']
        # si la cantidad de menores seleccionada es mayor a 0
        if int(cl_mens) > 0:
            # se valida que la suma de menores y mayores sea menor a 5
            if (int(cl_ads) + int(cl_mens)) > 5:
                raise forms.ValidationError('Máxima cantidad de personas = 5')
        # se devuelven los datos
        data = cl_mens
        return data
    # huesped = forms.ModelChoiceField(queryset=Estado.objects.filter(ambito='cab'))
    # form helper para agregar el boton de submit y definir el metodo post en el formulario
    helper = FormHelper()
    helper.add_input(Submit("submit", "Confirmar", css_class="btn-primary cuac"))
    helper.form_method = "POST"
    helper.form_style = "inline"
