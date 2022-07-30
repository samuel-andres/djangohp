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