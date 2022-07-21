import datetime
from django import forms
from django.utils.translation import gettext_lazy as _
from django.contrib.auth.models import User
from bootstrap_daterangepicker import widgets
from bootstrap_daterangepicker import fields
from crispy_forms.helper import FormHelper
from crispy_forms.layout import Submit, Layout, Field
from inquilinos.models import Reserva, Estado


class RegResForm(forms.Form):
    cant_adultos_choices = [
        (1, 'Uno'),
        (2, 'Dos'),
        (3, 'Tres'),
        (4, 'Cuatro'),
        (5, 'Cinco'),
    ]
    fechaDesdeHasta =  fields.DateRangeField(
        label='Rango de reserva:'
        )
    cantAdultos = forms.ChoiceField(
        choices=cant_adultos_choices,
        label='Cantidad de adultos'
        )
    # huesped = forms.ModelChoiceField(queryset=Estado.objects.filter(ambito='cab'))
    helper = FormHelper()
    helper.add_input(Submit('submit', 'Submit', css_class='btn-primary cuac'))
    helper.form_method = 'POST'
    helper.form_style = 'inline'
