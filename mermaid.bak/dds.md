
``` mermaid
sequenceDiagram
    actor HUE as Huesped
    participant VIEW as RegistroReservaView
    PARTICIPANT FORM as RegResForm
    participant CAB as Cab
    participant ACAB as slug:Cab
    participant RANGO as deCabaña:Rango
    participant RESERVA as deReserva:Reserva
    participant TEMP_ENG as TemplateEngine
    participant NRES as nueva:Reserva
    participant ESTADO as Estado
    participant NCE as nuevo:CambioEstado
    HUE ->> VIEW: http Request GET(slug, request)
    VIEW ->> RegResForm: new(slug)
    loop 
        VIEW ->> CAB: get(slug=slug)
    end
    VIEW ->> ACAB: get_costo_por_noche()
    VIEW ->> ACAB: get_fechas_hab_y_des()
    ACAB ->> ACAB: get_fechas_habilitadas()
    loop
        ACAB ->> RANGO: get_fecha_inicio()
        ACAB ->> RANGO: get_fecha_fin()
    end
    ACAB ->> ACAB: get_fechas_deshabilitadas()
    loop
        ACAB ->> RESERVA: get_fecha_inicio()
        ACAB ->> RESERVA: get_fecha_fin()
    end
    VIEW ->> VIEW: parse_fecha_actual()
    VIEW ->> TEMP_ENG: render(request, template, context)
    VIEW ->> HUE: http Response(reg_res.html, staticfiles)
    HUE ->> VIEW: http Request POST(fecha_desde, fecha_hasta, cant_adultos, cant_menores)
    VIEW ->> FORM: new(slug, POST data)
    VIEW ->> FORM: is_valid()
    FORM ->> FORM: clean(POST data)
    VIEW ->> FORM: get_cleaned_fechaDesdeHasta()
    VIEW ->> VIEW: parse_picker_input()
    VIEW ->> FORM: get_cleaned_cantAdultos()
    VIEW ->> FORM: get_cleaned_cantMenores()
    VIEW ->> ACAB: crear_reserva(datos_reserva)
    CAB ->> NRES: new(datos_reserva)
    CAB ->> NRES: set_precio_final()
    NRES ->> NRES: calcular_precio_final()
    CAB ->> NRES: set_estado('Pte Confirmacion')
    loop
        NRES ->> ESTADO: get(nombre='Pte Confirmacion')
    end
    NRES ->> NCE: new(reserva, estado)
    CAB ->> NRES: send_mail_enc_res()
    VIEW ->> HUE: http ResponseRedirect (res-det)
```