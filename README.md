``` mermaid
classDiagram

    class User{

    }

    User "0..*" <--> "1..*" Group

    class Group{

    }

    Huesped --|> User
    Huesped --> "1" Group

    class Huesped{

    }

    class Comentario{
        -int calificacion
    }

    Reserva --> "1" Cabaña
    Cabaña --> "0..*" Comentario
    Comentario --> "1" Huesped
    Reserva --> "1" Huesped
    Reserva --> "1" Estado
    Cabaña --> "0..*" Foto
    Cabaña "1..*" <--> "0..*" Promocion
    Cabaña --> "1..*" TipoDeServicio
    Reserva --> "0..*"  TipoDeServicio
    Cabaña --> "0..*" Instalacion
    Reserva --> "0..*" Instalacion
    Cabaña --> "0..*" Rango

    class Reserva{
        -date fechaDesde
        -date fechaHasta
        -int cantAdultos
        -int cantNiños
        -Huesped huesped
        -Cabaña cabaña
        -Estado estado
    }

    class Cabaña{
        +str ubicacion
        +str nombre
        -int cantHabitaciones
        -TipoDeServicio servicio
        -Instalacion instalacion
        -Foto foto
        -Comentario comentario
        -Rango rango
        -Estado estado
    }

    class Estado{
        +str nombre
        +str ambito
    }

    class Foto{
        -img foto
        -fecha
    }

    class Promocion {
        -int pjeDescuento
        -cabaña Cabaña
    }

    class TipoDeServicio{
        -nombre
    }

    class Instalacion{
        -nombre
    }

    class Rango {
        +date fechaDesde
        +date fechaHasta
    }

```