from django.contrib.auth.mixins import LoginRequiredMixin
from django.shortcuts import get_object_or_404
from django.views import generic

from .models import Huesped


class UserCreateView(LoginRequiredMixin, generic.edit.CreateView):
    """sobreescribe el  método form_valid agregando un paso más a la validación del form,
    que es setearle el usuario que hace el request"""

    def form_valid(self, form):
        object = form.save(commit=False)
        object.usuario = self.request.user
        object.save()
        return super(UserCreateView, self).form_valid(form)


class HuespedOwnerListView(LoginRequiredMixin, generic.ListView):
    def get_queryset(self):
        """sobreescribe el método get_queryset para que un huesped solo tenga acceso
        a las las reservas realizadas por el"""
        qs = super(HuespedOwnerListView, self).get_queryset()
        return qs.filter(huesped=self.request.user.huesped)


class HuespedOwnerDetailView(LoginRequiredMixin, generic.DetailView):
    def get_queryset(self):
        """sobreescribe el método get_queryset para que un huesped solo tenga acceso
        a la reserva realizadas por el"""
        qs = super(HuespedOwnerDetailView, self).get_queryset()
        return qs.filter(huesped=self.request.user.huesped)
