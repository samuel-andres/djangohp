<p align="center">
  <img src="./mdimages/2022-07-30-18-29-20.png"/>
</p>

![](./mdimages/logo2%20-%20copia.png)

## Proyecto: 
- Reserva de cabañas

## Materia: 
- Habilitación profesional

## Docentes:
- Ing. Valeria Abdala

## Equipo "UNISOFT":
-   Alvarez Joaquin                          alvarezdjoaquin@gmail.com 
-	Andres Samuel                            samuel5848@gmail.com 
-	Pairetti Franca                            franpairetti@gmail.com 
-	Zoy Eder Nahuel                         ederzoy6@gmail.com

## Producto: 
- Software para la gestión de reservas de cabañas.

## Nombre del producto
- RentCab

## Notion
- <a href="https://www.notion.so/26194ecc630d42e9b03eca7938eae158?v=0aea7ccf0db449918457444431d7a86c"> notion.so/rentcab </a>

<hr/>

## DDC

``` mermaid
classDiagram

    class User{
        -username
        -password
        -email
    }

    User "0..*" <--> "1..*" Group

    class Group{
        -permisos
    }

    Huesped --> "1" User

    class Huesped{
        -str nombre
        -str apellido
        -str telefono
        -User usuario
        +asignar_permiso()
    }

    Reserva --> "1" Cabaña
    Reserva --> "1" Huesped
    Reserva --> "1..*" CambioEstado 
    Cabaña --> "0..*" Foto
    Cabaña --> "0..*" Instalacion
    Reserva --> "0..*" Instalacion
    Cabaña --> "0..*" Rango
    CambioEstado --> "1" Estado

    class Reserva{
        -date fechaDesde
        -date fechaHasta
        -date fechaReserva
        -float precioFinal
        -int cantAdultos
        -int cantMenores
        -Huesped huesped
        -Cabaña cabaña
        -CambioEstado cambioEstado
    }

    class Cabaña{
        -str ubicacion
        -str nombre
        -int cantHabitaciones
        -int costoPorNoche
        -Instalacion instalacion
        -Foto foto
        -Rango rango
        -Estado estado
    }

    class CambioEstado{
        -fechaInicio date
        -fechaFin date
        -estado Estado
    }

    class Estado{
        +str nombre
        +str ambito
    }

    class Foto{
        -img foto
        -str descripcion
    }

    class Instalacion{
        -nombre
        -descripcion
    }

    class Rango {
        +date fechaDesde
        +date fechaHasta
    }

```

## DDS - CU Registrar Reserva

``` mermaid
sequenceDiagram
    actor HUE as Huesped
    participant VIEW as RegistroReservaView
    VIEW ->> RegResForm: new(slug)
    participant CAB as Cab
    participant ACAB as slug:Cab
    participant RANGO as deCabaña:Rango
    participant RESERVA as deReserva:Reserva
    participant TEMP_ENG as TemplateEngine
    participant NRES as nueva:Reserva
    participant ESTADO as Estado
    participant NCE as nuevo:CambioEstado
    HUE ->> VIEW: http Request GET(slug, request)
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
    ACAB ->> ACAB: context(fechas_habilitadas, fechas_deshabilitadas, costoPorNoche, form)
    VIEW ->> TEMP_ENG: render(request, template, context)
    VIEW ->> HUE: http Response(reg_res.html, staticfiles)
    HUE ->> VIEW: http Request POST(fecha_desde, fecha_hasta, cant_adultos, cant_menores)
    VIEW ->> FORM: new(slug, POST data)
    VIEW ->> FORM: is_valid()
    FORM ->> FORM: clean(POST data)
    VIEW ->> FORM: get_cleaned_fechaDesdeHasta()
    VIEW ->> VIEW: parse_fechaDesdeHasta()
    VIEW ->> FORM: get_cleaned_cantAdultos()
    VIEW ->> FORM: get_cleaned_cantMenores()
    VIEW ->> ACAB: crear_reserva(datos_reserva)
    VIEW ->> HUE: http ResponseRedirect (res-det)
    CAB ->> NRES: new(datos_reserva)
    CAB ->> NRES: set_precio_final()
    NRES ->> NRES: calcular_precio_final()
    CAB ->> NRES: set_estado('Pte Confirmacion')
    loop
        NRES ->> ESTADO: get(nombre='Pte Confirmacion')
    end
    NRES ->> NCE: new(reserva, estado)
```