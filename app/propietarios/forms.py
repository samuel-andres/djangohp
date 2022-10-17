
from django.contrib.auth.forms import AuthenticationForm
from django import forms
from .models import *
from django.conf import settings

from inquilinos.models import Cab, Huesped, Rango, Foto , Instalacion

#CABAÑA
class RegCabForm(forms.ModelForm):
    def __init__(self, *args, **kwargs):
        super(RegCabForm, self).__init__(*args, **kwargs)
        for field in self.fields:
            self.fields[field].widget.attrs = {
                'class': 'form-control mb-2'
            }
    class Meta:
        model = Cab
        fields = [
            'nombre',
            'cantHabitaciones' ,
            # 'costoPorNoche',
        ]

#RANGO
class RegRangoForm(forms.ModelForm):
    def __init__(self, *args, **kwargs):
        super(RegRangoForm, self).__init__(*args, **kwargs)
        for field in self.fields:
            self.fields[field].widget.attrs = {
                'class': 'form-control mb-2'
            }
    class Meta:
        model = Rango
        fields = [ 'fechaDesde' , 'fechaHasta']
        widgets = {
            'fechaDesde': forms.DateInput(format = '%Y-%m-%d',attrs={'type': 'date'}),
            'fechaHasta': forms.DateInput(format = '%Y-%m-%d',attrs={'type': 'date'}),
        }

#FOTO
class RegFotoForm(forms.ModelForm):
    def __init__(self, *args, **kwargs):
        super(RegFotoForm, self).__init__(*args, **kwargs)
        for field in self.fields:
            self.fields[field].widget.attrs = {
                'class': 'form-control mb-2'
            }
    class Meta:
        model = Foto
        fields = [ 'foto' , 'descripcion']

#INSTALACION
class RegInstalacionForm(forms.ModelForm):
    def __init__(self, *args, **kwargs):
        super(RegInstalacionForm, self).__init__(*args, **kwargs)
        for field in self.fields:
            self.fields[field].widget.attrs = {
                'class': 'form-control mb-2'
            }
    class Meta:
        model = Instalacion
        fields = [ 'nombre' , 'descripcion']
        widgets = {
            'descripcion': forms.Textarea(
                attrs = {
                    'placeholder':'',
                    'rows':'6'
                }
            ),
        }

#SERVICIOS
class RegServiciosForm(forms.ModelForm):
    def __init__(self, *args, **kwargs):
        super(RegServiciosForm, self).__init__(*args, **kwargs)
        for field in self.fields:
            self.fields[field].widget.attrs = {
                'class': 'form-control mb-2'
            }
    class Meta:
        model = Servicio
        fields = [ 'nombre' , 'descripcion']
        widgets = {
            'descripcion': forms.Textarea(
                attrs = {
                    'placeholder':'',
                    'rows':'6'
                }
            ),
        }

#PROMOCION
class DateInput(forms.DateInput):
    input_type = 'date'
    #input_formats=settings.DATE_INPUT_FORMATS

class RegPromoForm(forms.ModelForm):
    def __init__(self, *args, **kwargs):
        super(RegPromoForm, self).__init__(*args, **kwargs)
        for field in self.fields:
            self.fields[field].widget.attrs = {
                'class': 'form-control mb-2'
            }
    class Meta:
        model = Promocion
        fields = ['descripcion' ,'titulo' , 'fechaInicio' , 'fechaFin', 'descuento', 'cab']
        widgets = {
            'descripcion': forms.Textarea(
                attrs = {
                    'placeholder':'',
                    'rows':'6'
                }
            ),
            'cab':forms.Select(),
            'fechaInicio': forms.DateInput(format = '%Y-%m-%d',attrs={'type': 'date'}),
            'fechaFin': forms.DateInput(format = '%Y-%m-%d',attrs={'type': 'date'}),
        }

#HUESPED
class RegHuespedForm(forms.ModelForm):
    def __init__(self, *args, **kwargs):
        super(RegHuespedForm, self).__init__(*args, **kwargs)
        for field in self.fields:
            self.fields[field].widget.attrs = {
                'class': 'form-control mb-2'
            }
    class Meta:
        model = Huesped
        fields = [ 'nombre' , 'apellido','telefono']