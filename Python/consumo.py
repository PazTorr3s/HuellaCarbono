from Sostenibilidad_Empresarial.models import Analisis, Recopilacion
import datetime

def analisis(consumo_nuevo, fecha_consumo):
    try:
        año_consumo = fecha_consumo.year
        
        # Crear la fecha del primer día del año correspondiente
        año_fecha = datetime.date(año_consumo, 1, 1)

        # Buscar el análisis existente para el año
        analisis_existente = Analisis.objects.filter(año=año_fecha).first()

        if analisis_existente:
            # Si existe, actualizar los datos
            datos_existentes = analisis_existente.datos
            for key in consumo_nuevo:
                if key in datos_existentes:
                    datos_existentes[key] = float(datos_existentes[key]) + float(consumo_nuevo[key])

            analisis_existente.datos = datos_existentes
            analisis_existente.save()
            print(f"Análisis actualizado para el año {año_consumo}: {datos_existentes}")
        else:
            # Si no existe, crear un nuevo análisis
            Analisis.objects.create(año=año_fecha, datos=consumo_nuevo)
            print(f"Nuevo análisis creado para el año {año_consumo}: {consumo_nuevo}")
    
    except Exception as e:
        print(f"Error en el análisis: {e}")
