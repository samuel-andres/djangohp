from django.contrib.auth.mixins import LoginRequiredMixin
from django.views import generic
from .models import Huesped
from django.shortcuts import get_object_or_404


class UserCreateView(LoginRequiredMixin, generic.edit.CreateView):
    """sobreescribe el  método form_valid agregando un paso más a la validación del form,
    que es setearle el usuario que hace el request"""

    def form_valid(self, form):
        object = form.save(commit=False)
        object.usuario = self.request.user
        object.save()
        return super(UserCreateView, self).form_valid(form)
