from django.urls import path
from Sostenibilidad_Empresarial.views import *
urlpatterns = [
    path('', index, name='index'),
    path('login/', login, name='login'),
    path('index_admin/', index_admin, name='index_admin'),
    path('register/', register, name='register'),
    path('nosotros/', nosotros, name='nosotros'),
    path('reportes/', reportes, name='reportes'),
    path('alertas/', alertas, name='alertas'),
    path('consumo/', consumo, name='consumo'),
    path('administradores/', administradores, name='administradores'),
    path('eliminar_admin/<int:id>/', eliminar_admin, name='eliminar_admin'),
    path('recuperar/', recuperar, name='recuperar'),
    path('cambiar_contrasena/', cambiar_contrasena, name='cambiar_contrasena'),
    path('datos/', datos, name='datos'),
    path('editar/<int:id>/', editar, name='editar'),
    path('eliminar/<int:id>/', eliminar, name='eliminar'),
    path('generar_reporte_energia/', generar_reporte_energia, name='generar_reporte_energia'), 
    path('generar_reporte_residuos/', generar_reporte_residuos, name='generar_reporte_residuos'), 
    path('generar_reporte_huella/', generar_reporte_huella, name='generar_reporte_huella'),
]
