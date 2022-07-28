"""locallibrary URL Configuration"""
from django.contrib import admin
from django.urls import path, include
from django.views.generic import RedirectView
from django.conf import settings
from django.conf.urls.static import static
from django.contrib.auth.models import User
from api.routers import router

urlpatterns = [
    path("", RedirectView.as_view(url="inquilinos/", permanent=True)),
    path("inquilinos/", include("inquilinos.urls")),
    path("propietarios/", include("propietarios.urls")),
    path("admin/", admin.site.urls),
    path('api-auth/', include('rest_framework.urls')),
    path('test-endpoint/', include(router.urls)),
    path("accounts/", include("accounts.urls")),
    path('accounts/', include('django.contrib.auth.urls')),
] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
