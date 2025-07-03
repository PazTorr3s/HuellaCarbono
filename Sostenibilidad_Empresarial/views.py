from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.hashers import make_password
from django.contrib.auth.hashers import check_password
from django.core.mail import send_mail
from django.contrib.auth import update_session_auth_hash
from django.contrib.auth.hashers import check_password
from django.conf import settings
from .models import Administrador
from .models import Recurso
from .models import Consumo
from .models import Analisis
from django.db import IntegrityError
import random
from django.db.models import Q
from Python.consumo import *
from datetime import datetime, date
import json
from django.http import HttpResponse 
from reportlab.lib.pagesizes import letter 
from reportlab.pdfgen import canvas
import textwrap


def index(request):
    año_actual = datetime.now().year
    
    analisis = Analisis.objects.filter(año__year=año_actual)
    
    data = []
    total_suma = 0

    for a in analisis:
        suma = sum(float(v) for v in a.datos.values())
        total_suma += suma

        
        data.append({
            'name': f'Consumo año {a.año.year}',
            'y': suma 
        })
    

    consumos = Consumo.objects.filter(fecha_consumo__year=año_actual)

    consumo_co2 = [0] * 12

    for consumo in consumos:
        mes = consumo.fecha_consumo.month - 1
        datos = consumo.datos
        if isinstance(datos, str):
            datos = eval(datos)

        for tipo, cantidad in datos.items():
            if tipo == 'CO2':
                consumo_co2[mes] += float(cantidad)


    recursos = Recurso.objects.all()
    context = {
        'consumo_co2':consumo_co2,
        'data':data,
        'total_suma':total_suma
    }

    return render(request, 'index.html',context)



def nosotros(request):
    return render(request, 'nosotros.html')

def login(request):
    if request.method == 'POST':
        correo = request.POST.get('correo')
        contrasena = request.POST.get('contrasena')
        
        try:
            admin = Administrador.objects.get(correo=correo)
            if check_password(contrasena, admin.contrasena):
                request.session['admin_id'] = admin.id
                estado = admin.estado
                if estado == 'Autorizado':
                    return redirect('index_admin')
                else:
                    return render(request, 'login.html', {'error': 'Cuenta no Autorizada, Comuniquese con el encargado de la empresa para ser autorizado.'})
            else:
                return render(request, 'login.html', {'error': 'Credenciales inválidas.'})
        except Administrador.DoesNotExist:
            return render(request, 'login.html', {'error': 'Ingrese una credencial valida.'})

    return render(request, 'login.html')

def index_admin(request):
    if 'admin_id' not in request.session:
        return redirect('login')

    año_actual = datetime.now().year
    consumos = Consumo.objects.filter(fecha_consumo__year=año_actual)

    consumo_diesel = [0] * 12
    consumo_basura = [0] * 12
    consumo_agua = [0] * 12
    consumo_electricidad = [0] * 12
    consumo_produccion = [0] * 12
    consumo_materia = [0] * 12
    consumo_co2 = [0] * 12
    consumo_gas = [0] * 12

    for consumo in consumos:
        mes = consumo.fecha_consumo.month - 1
        datos = consumo.datos 

        if isinstance(datos, str):
            datos = eval(datos) 

        for tipo, cantidad in datos.items():
            if tipo == 'Diesel':
                consumo_diesel[mes] += float(cantidad)
            elif tipo == 'Basura':
                consumo_basura[mes] += float(cantidad)
            elif tipo == 'Agua':
                consumo_agua[mes] += float(cantidad)
            elif tipo == 'Electricidad':
                consumo_electricidad[mes] += float(cantidad)
            elif tipo == 'Producción':
                consumo_produccion[mes] += float(cantidad)
            elif tipo == 'Materia prima':
                consumo_materia[mes] += float(cantidad)
            elif tipo == 'CO2':
                consumo_co2[mes] += float(cantidad)
            elif tipo == 'Gas':
                consumo_gas[mes] += float(cantidad)

    recursos = Recurso.objects.all()

    analisis = Analisis.objects.filter(año__year=año_actual)

    primer_analisis = analisis.first()

    if primer_analisis and primer_analisis.datos:
        valor_agua = primer_analisis.datos.get("Agua")
        valor_co2 = primer_analisis.datos.get("CO2")
        valor_electricidad = primer_analisis.datos.get("Electricidad")
        valor_Diesel = primer_analisis.datos.get("Diesel")

    context = {
        'consumo_diesel': consumo_diesel,
        'consumo_basura': consumo_basura,
        'consumo_agua': consumo_agua,
        'consumo_electricidad': consumo_electricidad,
        'consumo_produccion': consumo_produccion,
        'consumo_materia': consumo_materia,
        'consumo_co2':consumo_co2,
        'consumo_gas':consumo_gas,
        'recursos':recursos,
        'agua': valor_agua,
        'co2': valor_co2,
        'electricidad': valor_electricidad,
        'diesel':valor_Diesel
    }


    
    return render(request, 'index_admin.html', context)

def consumo(request):
    if 'admin_id' not in request.session:
        return redirect('login')


    recursos = Recurso.objects.all()
    recursos_contexto = {'recursos': recursos}

    if request.method == 'POST':
        try:
            admin = Administrador.objects.get(id=request.session['admin_id'])
            user_consumo = admin.correo
            fecha_consumo = request.POST.get('fecha_consumo') 

            if not fecha_consumo:
                return render(request, 'consumo.html', {**recursos_contexto, 'error': 'Por favor ingrese una fecha de consumo.'})

            fecha_completa = f"{fecha_consumo}-01" 

 
            fecha_obj = datetime.strptime(fecha_completa, "%Y-%m-%d").date()  


            mes_año = fecha_obj.strftime("%Y-%m")
            if Consumo.objects.filter(fecha_consumo__startswith=mes_año).exists():
                return render(request, 'consumo.html', {**recursos_contexto, 'edit': 'El Mes y Año seleccionado ya contiene datos',})

       
            datos = {}
            for key in request.POST.keys():
                if key.startswith('recurso_'):
                    index = key.split('_')[1]
                    recurso = request.POST.get(f'recurso_{index}')
                    consumo = request.POST.get(f'consumo_{index}')
                    if recurso and consumo:
                        datos[recurso] = consumo


            save = Consumo(datos=datos, fecha_consumo=fecha_obj, user_consumo=user_consumo)
            save.save()
            analisis(datos, fecha_obj)

            print(f"Consumo guardado correctamente para el usuario {user_consumo} con fecha {fecha_obj}.")

            return render(request, 'consumo.html', {**recursos_contexto, 'ok': 'Datos guardados correctamente.'})

        except Exception as e:
            print(f"Error: {str(e)}")
            return render(request, 'consumo.html', {**recursos_contexto, 'error': f'Error Inesperado: {str(e)}'})

    return render(request, 'consumo.html', recursos_contexto)

def register(request):
    def validar_rut(rut):
        rut = rut.replace('.', '').replace('-', '').strip().upper()
        if len(rut) < 2:
            return False
        numero, digito_verificador = rut[:-1], rut[-1]
        if not numero.isdigit():
            return False
        suma, multiplicador = 0, 2
        for i in reversed(range(len(numero))):
            suma += int(numero[i]) * multiplicador
            multiplicador = multiplicador + 1 if multiplicador < 7 else 2
        resto = suma % 11
        dv_calculado = '0' if resto == 0 else 'K' if resto == 1 else str(11 - resto)
        return digito_verificador == dv_calculado

    def formatear_rut(rut):
        rut = rut.replace('.', '').replace('-', '').strip().upper()
        numero = rut[:-1]
        digito_verificador = rut[-1]
        rut_formateado = f"{int(numero):,}".replace(',', '.')
        return f"{rut_formateado}-{digito_verificador}"

    if request.method == 'POST':
        rut = request.POST.get('rut')
        correo = request.POST.get('correo')
        contrasena = request.POST.get('contrasena')

        if not rut or not validar_rut(rut):
            return render(request, 'register.html', {'error': 'El RUT es inválido'})

        rut_formateado = formatear_rut(rut)

        if Administrador.objects.filter(correo=correo).exists():
            return render(request, 'register.html', {'error': 'El correo ya está registrado'})

        if Administrador.objects.filter(rut=rut_formateado).exists():
            return render(request, 'register.html', {'error': 'El RUT ya está registrado'})

        contrasena_encriptada = make_password(contrasena)

        try:
            if rut_formateado == '21.765.466-1':
                estado = 'Autorizado'
            else:
                estado = 'No Autorizado'
            admin = Administrador(rut=rut_formateado, correo=correo, contrasena=contrasena_encriptada, estado=estado)
            admin.save()

            subject = 'Nuevo Registro'
            message = (
                f'Un nuevo usuario se ha registrado:\n\n'
                f'Rut: {rut_formateado}\n'
                f'Correo: {correo}\n'
                'Si el rut está autorizado, habilitalo dentro de tu web en la sección Administradores.'
            )
            recipient_list = ['sostenibilidad.emp@gmail.com']

            send_mail(subject, message, settings.EMAIL_HOST_USER, recipient_list)

            subject2 = 'Registro Exitoso - Notificación'
            message2 = (
                f'Hola,\n\n'
                f'Se ha registrado un nuevo usuario:\n'
                f'Rut: {rut_formateado}\n'
                f'Correo: {correo}\n'
                'Debes esperar a ser Autorizado por tu empresa para tener acceso como Administrador.\n'
                'Te informaremos mediante correo cuando seas Autorizado'
            )
            recipient2 = correo
            send_mail(subject2, message2, settings.EMAIL_HOST_USER, [recipient2])

        except IntegrityError as e:
            return render(request, 'register.html', {'error': 'Error al registrar el administrador: ' + str(e)})

        return redirect('login')

    return render(request, 'register.html')

def reportes(request):
    if 'admin_id' not in request.session:
        return redirect('login')
    
    return render(request, 'reportes.html')


def generar_reporte_energia(request):
    response = HttpResponse(content_type='application/pdf')
    response['Content-Disposition'] = 'attachment; filename="reporte_energia.pdf"'

    p = canvas.Canvas(response, pagesize=letter)
    width, height = letter

    def agregar_texto(p, texto, x, y, font="Helvetica", size=12, width_limit=70):
        p.setFont(font, size)
        for line in textwrap.wrap(texto, width=width_limit):
            p.drawString(x, y, line)
            y -= 15
            if y < 40:  # Límite de la página
                p.showPage()
                p.setFont(font, size)
                y = height - 50
        return y

    # Agregar título
    y_position = height - 50
    p.setFont("Helvetica-Bold", 20)
    p.drawString(100, y_position, "Reporte de Consumo de Energía y Agua")
    y_position -= 40

    # Obtener datos del consumo de energía y agua
    año_actual = datetime.now().year
    consumos = Consumo.objects.filter(fecha_consumo__year=año_actual)
    
    consumo_electricidad = [0] * 12
    consumo_agua = [0] * 12
    meses = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"]

    for consumo in consumos:
        mes = consumo.fecha_consumo.month - 1
        datos = consumo.datos
        if isinstance(datos, str):
            datos = eval(datos)
        if 'Electricidad' in datos:
            consumo_electricidad[mes] += float(datos['Electricidad'])
        if 'Agua' in datos:
            consumo_agua[mes] += float(datos['Agua'])

    total_electricidad_anual = 0
    total_agua_anual = 0

    # Mostrar consumo mensual de electricidad
    y_position -= 20
    p.setFont("Helvetica-Bold", 14)
    p.drawString(100, y_position, "Consumo de Electricidad por Mes (kWh):")
    y_position -= 20
    for mes, total in zip(meses, consumo_electricidad):
        y_position = agregar_texto(p, f"{mes}: {total:.2f} kWh", 100, y_position)
        total_electricidad_anual += total

    # Mostrar consumo total anual de electricidad
    y_position -= 10
    y_position = agregar_texto(p, f"Consumo Total Anual de Electricidad: {total_electricidad_anual:.2f} kWh", 100, y_position)
    y_position -= 20

    # Mostrar consumo mensual de agua
    p.setFont("Helvetica-Bold", 14)
    p.drawString(100, y_position, "Consumo de Agua por Mes (litros):")
    y_position -= 20
    for mes, total in zip(meses, consumo_agua):
        y_position = agregar_texto(p, f"{mes}: {total:.2f} litros", 100, y_position)
        total_agua_anual += total

    # Mostrar consumo total anual de agua
    y_position -= 10
    y_position = agregar_texto(p, f"Consumo Total Anual de Agua: {total_agua_anual:.2f} litros", 100, y_position)
    y_position -= 40

    # Agregar recomendaciones para reducir el consumo de energía y agua
    recomendaciones = [
        "1. Apagar equipos eléctricos cuando no estén en uso.",
        "2. Utilizar bombillas LED en lugar de incandescentes.",
        "3. Implementar sistemas de gestión de energía.",
        "4. Mejorar el aislamiento térmico de los edificios.",
        "5. Utilizar temporizadores y sensores de movimiento para la iluminación.",
        "6. Reparar fugas de agua inmediatamente.",
        "7. Instalar dispositivos de ahorro de agua como aireadores en grifos.",
        "8. Utilizar sistemas de riego eficientes para las áreas verdes."
    ]

    p.setFont("Helvetica-Bold", 14)
    p.drawString(100, y_position, "Recomendaciones para reducir el consumo de energía y agua:")
    y_position -= 20
    for rec in recomendaciones:
        y_position = agregar_texto(p, rec, 100, y_position)
        y_position -= 10

    p.showPage()
    p.save()
    return response


def generar_reporte_residuos(request):
    response = HttpResponse(content_type='application/pdf')
    response['Content-Disposition'] = 'attachment; filename="reporte_residuos.pdf"'

    p = canvas.Canvas(response, pagesize=letter)
    width, height = letter

    # Agregar título
    p.setFont("Helvetica-Bold", 20)
    p.drawString(100, height - 50, "Reporte de Residuos Generados")

    # Obtener datos de los residuos generados
    año_actual = datetime.now().year
    consumos = Consumo.objects.filter(fecha_consumo__year=año_actual)
    
    consumo_basura = [0] * 12
    meses = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"]

    for consumo in consumos:
        mes = consumo.fecha_consumo.month - 1
        datos = consumo.datos
        if isinstance(datos, str):
            datos = eval(datos)
        if 'Basura' in datos:
            consumo_basura[mes] += float(datos['Basura'])

    y_position = height - 100
    total_anual = 0

    for mes, total in zip(meses, consumo_basura):
        p.setFont("Helvetica", 12)
        p.drawString(100, y_position, f"{mes}: {total:.2f} kg")
        y_position -= 20
        total_anual += total

    y_position -= 20
    p.setFont("Helvetica-Bold", 12)
    p.drawString(100, y_position, f"Total Anual de Residuos: {total_anual:.2f} kg")

    # Agregar recomendaciones para la gestión de residuos
    recomendaciones = [
        "1. Implementar programas de reciclaje.",
        "2. Reducir el uso de plásticos de un solo uso.",
        "3. Fomentar la compostación de residuos orgánicos.",
        "4. Mejorar la segregación de residuos en origen.",
        "5. Promover la reutilización de materiales."
    ]

    y_position -= 40
    p.setFont("Helvetica-Bold", 14)
    p.drawString(100, y_position, "Recomendaciones para la gestión de residuos:")
    y_position -= 20
    for rec in recomendaciones:
        p.setFont("Helvetica", 12)
        p.drawString(100, y_position, rec)
        y_position -= 20

    p.showPage()
    p.save()
    return response


def generar_reporte_huella(request):
    response = HttpResponse(content_type='application/pdf')
    response['Content-Disposition'] = 'attachment; filename="reporte_huella_carbono.pdf"'

    p = canvas.Canvas(response, pagesize=letter)
    width, height = letter

    def agregar_texto(p, texto, x, y, font="Helvetica", size=12, width_limit=70):
        p.setFont(font, size)
        for line in textwrap.wrap(texto, width=width_limit):
            p.drawString(x, y, line)
            y -= 15
            if y < 40:  # Límite de la página
                p.showPage()
                p.setFont(font, size)
                y = height - 50
        return y

    # Agregar título
    y_position = height - 50
    p.setFont("Helvetica-Bold", 20)
    p.drawString(100, y_position, "Reporte de Huella de Carbono")
    y_position -= 40

    # Obtener datos de la huella de carbono
    año_actual = datetime.now().year
    consumos = Consumo.objects.filter(fecha_consumo__year=año_actual)
    
    consumo_co2 = [0] * 12
    meses = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"]

    for consumo in consumos:
        mes = consumo.fecha_consumo.month - 1
        datos = consumo.datos
        if isinstance(datos, str):
            datos = eval(datos)
        if 'CO2' in datos:
            consumo_co2[mes] += float(datos['CO2'])

    total_anual = 0

    for mes, total in zip(meses, consumo_co2):
        p.setFont("Helvetica", 12)
        p.drawString(100, y_position, f"{mes}: {total:.2f} toneladas")
        y_position -= 20
        total_anual += total
        if y_position < 40:  # Verificar si necesitamos crear una nueva página
            p.showPage()
            y_position = height - 50

    y_position -= 20
    p.setFont("Helvetica-Bold", 12)
    p.drawString(100, y_position, f"Total Anual de Huella de Carbono: {total_anual:.2f} toneladas")
    y_position -= 40

    # Agregar un texto introductorio sobre medidas ambientalistas
    p.setFont("Helvetica-Bold", 14)
    p.drawString(100, y_position, "Medidas Ambientalistas:")
    y_position -= 20
    texto_medidas = """
La huella de carbono representa la cantidad de emisiones de gases de efecto invernadero producidas directa o indirectamente por nuestras actividades. Reducirla no solo es vital para combatir el cambio climático, sino que también puede generar beneficios económicos y mejorar la imagen pública de la empresa. Las siguientes medidas están diseñadas para ayudar a su empresa a reducir significativamente su huella de carbono
    """
    y_position = agregar_texto(p, texto_medidas, 100, y_position)

    # Agregar recomendaciones para reducir la huella de carbono
    y_position -= 20
    p.setFont("Helvetica-Bold", 14)
    p.drawString(100, y_position, "Recomendaciones para reducir la huella de carbono:")
    y_position -= 20
    recomendaciones = [
        "1. Implementar programas de reciclaje: Establecer un sistema de reciclaje efectivo para reducir los residuos enviados a vertederos.\n",
        "2. Mejorar la eficiencia energética de los edificios: Aislar mejor los edificios, utilizar iluminación LED y sistemas de calefacción y refrigeración eficientes.\n",
        "3. Utilizar fuentes de energía renovable: Instalar paneles solares o comprar energía proveniente de fuentes renovables.\n",
        "4. Reducir el uso de vehículos de combustibles fósiles: Fomentar el uso de vehículos eléctricos y compartir viajes entre empleados.\n",
        "5. Promover el uso de transporte público y bicicletas: Incentivar el uso de transporte público y la infraestructura para bicicletas.\n",
        "6. Optimizar los procesos industriales: Implementar tecnologías más eficientes que reduzcan el consumo de energía y emisiones.\n",
        "7. Fomentar la educación y concienciación ambiental: Capacitar a los empleados sobre prácticas sostenibles y su impacto positivo.\n",
        "8. Compensar emisiones: Participar en programas de compensación de carbono mediante la plantación de árboles o apoyo a proyectos de energía verde.\n"
    ]

    for rec in recomendaciones:
        y_position = agregar_texto(p, rec, 100, y_position)
        y_position -= 10

    p.showPage()
    p.save()
    return response

def datos(request):
    if 'admin_id' not in request.session:
        return redirect('login')

    busqueda = request.GET.get("buscar") 
    if busqueda:
    
        consumo = Consumo.objects.filter(
            Q(fecha_consumo__icontains=busqueda) |
            Q(user_consumo__icontains=busqueda) 
        ).distinct()
    else:
        consumo = Consumo.objects.all()
    
    data = {'consumo': consumo, 'buscar': busqueda}
    return render(request, 'datos.html', data)

def editar(request, id):
    if 'admin_id' not in request.session:
        return redirect('login')

    consumo = get_object_or_404(Consumo, id=id)
    data = {'consumo': consumo}
    
    if request.method == 'POST':
        datos_str = request.POST.get('datos')

        try:
            datos_str = datos_str.replace("'", '"')

            consumo.datos = json.loads(datos_str)

        except json.JSONDecodeError:
            data['error'] = "Formato JSON inválido. Por favor, revisa los datos."
            return render(request, 'editar.html', data)
        
        consumo.save()
        
        return redirect('datos')

    return render(request, 'editar.html', data)

def eliminar(request, id):
    if 'admin_id' not in request.session:
        return redirect('login')


    consumo = get_object_or_404(Consumo, id=id)
    consumo.delete()
    consumo = Consumo.objects.all()
    data = {'consumo': consumo}
    return render(request,'datos.html',data)

def alertas(request):
    if 'admin_id' not in request.session:
        return redirect('login')


    datos = consumo(request)
    context = {
        'datos': datos,
    }
    return render(request, 'alertas.html', context)

def administradores(request):
    rut_autorizado = '21.846.879-9'

    if 'admin_id' not in request.session:
        mensaje = 'Acceso no autorizado'
        return render(request, 'administradores.html', {'mensaje': mensaje})

    try:
        admin = Administrador.objects.get(id=request.session['admin_id'])
    except Administrador.DoesNotExist:
        mensaje = 'Acceso no autorizado'
        return render(request, 'administradores.html', {'mensaje': mensaje})

    rut_usuario = admin.rut

    if rut_usuario != rut_autorizado:
        mensaje = 'Acceso no autorizado'
        return render(request, 'administradores.html', {'mensaje': mensaje})

    if request.method == 'POST':
        for admin_item in Administrador.objects.all():
            estado_checkbox = request.POST.get(f'estado_{admin_item.id}')
            if admin_item.id != admin.id:
                if estado_checkbox:
                    admin_item.estado = 'Autorizado'

                    subject = 'Administrador Autorizado'
                    message = (
                        f'El administrador con RUT {admin_item.rut} ha sido autorizado.\n'
                        'Puedes acceder a la plataforma y realizar las funciones necesarias.'
                    )
                    recipient_list = [admin_item.correo]

                    send_mail(subject, message, settings.EMAIL_HOST_USER, recipient_list)

                else:
                    admin_item.estado = 'No Autorizado'
                
                admin_item.save()

        admins = Administrador.objects.all()
        return render(request, 'administradores.html', {'admins': admins, 'admin': admin})

    admins = Administrador.objects.all()
    return render(request, 'administradores.html', {'admins': admins, 'admin': admin})

def eliminar_admin(request, id):
    if 'admin_id' not in request.session:
        return redirect('login')

    try:
        admin = Administrador.objects.get(id=id)
        admin.delete()
        return redirect('administradores')
    except Administrador.DoesNotExist:
        mensaje = 'Administrador no encontrado'
        return render(request, 'administradores.html', {'mensaje': mensaje})
    
def recuperar(request):
    def formatear_rut(rut):
        rut = rut.replace('.', '').replace('-', '').strip().upper()
        numero = rut[:-1]
        digito_verificador = rut[-1]
        rut_formateado = f"{int(numero):,}".replace(',', '.')
        return f"{rut_formateado}-{digito_verificador}"

    if request.method == 'POST':
        rut = request.POST.get('rut')
        correo = request.POST.get('correo')
        rut_formateado = formatear_rut(rut)

        try:
            admin = Administrador.objects.get(rut=rut_formateado)
            if correo == admin.correo:
                nueva_contrasena = str(random.randint(1001, 9999))
                admin.contrasena = make_password(nueva_contrasena)
                admin.save()
                
                subject = 'Recuperación de Contraseña'
                message = (
                    'Hola,\n\n'
                    'Haz solicitado recuperar tu contraseña. '
                    f'Tu contraseña temporal es: {nueva_contrasena}\n'
                    'Por favor, inicia sesión para cambiar tu contraseña temporal.\n\n'
                    'Gracias.'
                )
                recipient_list = [correo]
                send_mail(subject, message, settings.EMAIL_HOST_USER, recipient_list)

                return render(request, 'recuperar.html', {'ok': 'Correo enviado exitosamente. Verifica tu correo para recuperar la contraseña.'})
            else:
                return render(request, 'recuperar.html', {'error': 'Correo o RUT no encontrados.'})
        except Administrador.DoesNotExist:
            return render(request, 'recuperar.html', {'error': 'Ingrese una credencial válida.'})

    return render(request, 'recuperar.html')

def cambiar_contrasena(request):
    if 'admin_id' not in request.session:
        return redirect('login')



    if request.method == 'POST':
        contrasena_actual = request.POST.get('contrasena_actual')
        nueva_contrasena = request.POST.get('nueva_contrasena')
        
        admin_id = request.session.get('admin_id')
        if admin_id is None:
            return render(request, 'cambiar_contrasena.html', {'error': 'No estás autenticado'})

        try:
            admin = Administrador.objects.get(id=admin_id)

            if check_password(contrasena_actual, admin.contrasena):
                admin.contrasena = make_password(nueva_contrasena)
                admin.save()
                update_session_auth_hash(request, admin)
                return render(request, 'cambiar_contrasena.html', {'exito': 'Contraseña cambiada exitosamente'})
            else:
                return render(request, 'cambiar_contrasena.html', {'error': 'La contraseña actual es incorrecta'})
        except Administrador.DoesNotExist:
            return render(request, 'cambiar_contrasena.html', {'error': 'Administrador no encontrado'})
        
    return render(request, 'cambiar_contrasena.html')





















