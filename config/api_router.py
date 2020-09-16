from django.conf import settings
from rest_framework.routers import DefaultRouter, SimpleRouter
from django.urls import path
from ronatrack.users.api.views import CreateUserAPIView


if settings.DEBUG:
    router = DefaultRouter()
else:
    router = SimpleRouter()

router.register('create_user', CreateUserAPIView)

app_name = "api"
urlpatterns = router.urls

