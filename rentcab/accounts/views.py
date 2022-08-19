from django.contrib import messages
from django.http import HttpResponseRedirect
from django.shortcuts import render
from django.urls import reverse, reverse_lazy
# Create your views here.
from django.views import View, generic

# from django.contrib.auth.forms import UserCreationForm
from .forms import CrearUsuarioForm


class RegistrarseView(View):
    # cuando hagamos los administradores tenemos que cambiar esta vista por
    # registrarsecomocliente y crear otra que sea registrarsecomoadmin
    form_class = CrearUsuarioForm
    template_name = "accounts/signup.html"

    def post(self, request):
        form = self.form_class(request.POST)

        if form.is_valid():
            form.save()
            new_user = form.cleaned_data.get("username")
            messages.success(
                request,
                f"Bienvenid@ {new_user}!",
            )
            return HttpResponseRedirect(reverse_lazy("login"))

        context = {
            "form": form,
        }
        return render(request, self.template_name, context)

    def get(self, request):
        form = self.form_class()

        context = {
            "form": form,
        }

        return render(request, self.template_name, context)
