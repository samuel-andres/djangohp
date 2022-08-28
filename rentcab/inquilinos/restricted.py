from django.contrib.auth.mixins import LoginRequiredMixin, PermissionRequiredMixin
from django.shortcuts import get_object_or_404
from django.views import View, generic
from django.core.exceptions import PermissionDenied

from .models import Huesped


class UserRestrictedCreateView(LoginRequiredMixin, generic.edit.CreateView):
    """sobreescribe el  método form_valid agregando un paso más a la validación del form,
    que es setearle el usuario que hace el request"""

    def form_valid(self, form):
        object = form.save(commit=False)
        object.usuario = self.request.user
        object.save()
        return super(UserRestrictedCreateView, self).form_valid(form)


class HuespedRestrictedListView(LoginRequiredMixin, generic.ListView):
    def get_queryset(self):
        """sobreescribe el método get_queryset para que un huesped solo tenga acceso
        a las las reservas realizadas por el"""
        qs = super(HuespedRestrictedListView, self).get_queryset()
        try:
            return qs.filter(huesped=self.request.user.huesped).order_by("-id")
        except:
            raise PermissionDenied(self.admin_must_use_client_account_message)


class HuespedRestrictedUpdateView(LoginRequiredMixin, generic.UpdateView):
    def get_queryset(self):
        qs = super(HuespedRestrictedUpdateView, self).get_queryset()
        return qs.filter(huesped=self.request.user.huesped)


class HuespedRestrictedCreateView(LoginRequiredMixin, generic.CreateView):
    def get_queryset(self):
        qs = super(HuespedRestrictedUpdateView, self).get_queryset()
        return qs.filter(huesped=self.request.user.huesped)
