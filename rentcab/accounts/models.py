from django.conf import settings
from django.contrib.auth.models import (
    AbstractBaseUser,
    BaseUserManager,
    PermissionsMixin,
)
from django.db import models  # used for fields

# Create your models here.


class UserManager(BaseUserManager):
    """Manager for users"""

    def create_user(self, username, email, password=None):
        """
        Creates and saves a User with the given username, and password.
        """
        if not username:
            raise ValueError("Users must have a username")

        user = self.model(
            username=username,
            email=self.normalize_email(email),
        )

        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, username, email, password):
        """Creates and saves a new super user"""
        user = self.create_user(username, email, password)
        user.is_staff = True
        user.is_superuser = True
        user.save(using=self._db)

        user.is_admin = True
        user.save(using=self._db)
        return user


class User(AbstractBaseUser, PermissionsMixin):
    """User in the system. Inherits from AbstractBaseUser wich only define the password field.
    Mixins: PermissionsMixin"""

    username = models.CharField(
        max_length=255,
        unique=True,
    )

    email = models.EmailField(
        max_length=255,
        unique=True,
    )

    is_active = models.BooleanField(default=True)
    is_admin = models.BooleanField(default=False)
    is_staff = models.BooleanField(default=False)

    objects = UserManager()

    REQUIRED_FIELDS = ["email"]

    USERNAME_FIELD = "username"

    def __str__(self):
        return self.username
