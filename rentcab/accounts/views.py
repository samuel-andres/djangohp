from django.http import HttpResponseRedirect
from django.shortcuts import render
# Create your views here.
from django.views import View, generic
# from django.contrib.auth.forms import UserCreationForm
from .forms import CrearUsuarioForm
from django.urls import reverse, reverse_lazy
from django.contrib.auth.models import User
from django.contrib import messages

class RegistrarseView(View):
    form_class = CrearUsuarioForm
    template_name = 'accounts/signup.html'

    def post(self, request):
        form = self.form_class(request.POST)

        if form.is_valid():
            user = form.save()
            new_user = form.cleaned_data.get('username')
            messages.success(
                request,
                f'Bienvenido {new_user}!',
            )
            return HttpResponseRedirect(reverse_lazy('login'))

        context = {
            'form': form,
        }
        return render(request, self.template_name, context)

    def get(self, request):
        form = self.form_class()

        context = {
            'form': form,
        }

        return render(request, self.template_name, context)
