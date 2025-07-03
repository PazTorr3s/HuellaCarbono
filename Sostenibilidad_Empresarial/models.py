from django.db import models

class Administrador(models.Model):
    rut = models.CharField(max_length=12, unique=True)
    correo = models.EmailField(unique=True)
    contrasena = models.CharField(max_length=128)
    estado = models.CharField(max_length=13)

class Recurso(models.Model):
    nombre = models.CharField(max_length=50, unique=True)
    tipo = models.CharField(max_length=20)
    medida = models.CharField(max_length=20, default=None)

class Consumo(models.Model):
    fecha_consumo = models.DateField(null=True, blank=True)
    datos = models.JSONField()
    user_consumo = models.CharField(max_length=500, default=None)

class Analisis(models.Model):
    año = models.DateField(null=True, blank=True)
    datos = models.JSONField(default=dict)

class Recopilacion(models.Model):
    patrones = models.CharField(max_length=255)
    tendencias = models.CharField(max_length=255)
