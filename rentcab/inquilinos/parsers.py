import datetime


class CustomParser:
    def getParsedToday(self):
        """devuelve el día en string con formato dia mes año"""
        today = datetime.date.today()
        # se pasa el día de hoy de datetime obj a str
        return today.strftime("%d-%m-%Y")

    def parseRanges(self, ranges):
        """toma como argumento una lista de rangos y devuelve una lista de todas las fechas
        incluidas en los mismos parseadas para usar en js"""
        strp, strf, fmt = (
            datetime.datetime.strptime,
            datetime.datetime.strftime,
            "%d/%m/%Y",
        )
        foo = list()
        # se guardan todos los rangos (desde-hasta) en una lista
        for rango in ranges:
            foo.append(rango.fechaDesde.strftime("%d/%m/%Y"))
            foo.append(rango.fechaHasta.strftime("%d/%m/%Y"))

        # se generan todas las fechas intermedias entre los rangos especificados
        allowed_dates = [
            [
                strf(k, fmt)
                for k in (
                    strp(i, fmt) + datetime.timedelta(days=n)
                    for n in range((strp(j, fmt) - strp(i, fmt)).days + 1)
                )
            ]
            for i, j in zip(foo[::2], foo[1::2])
        ]

        # se flatea la lista (elimina los [])
        allowed_dates = [x for xs in allowed_dates for x in xs]
        return allowed_dates

    def parseReservas(self, reservas):
        """toma como argumento una lista de reservas y devuelve una lista con las fechas
        desde hasta de cada una en forma de listas"""
        disabled_dates = list()
        # se genera una lista de listas con los rangos a deshabilitar correspondientes a las reservas que existen en la db
        for reserva in reservas:
            bar = []
            bar.append(reserva.fechaDesde.strftime("%d/%m/%Y"))
            bar.append(reserva.fechaHasta.strftime("%d/%m/%Y"))
            disabled_dates.append(bar)

        return disabled_dates

    def parsePickerInput(self, pickerinput):
        """toma como argumento un string proveniente de un date range picker y devuelve
        una tupla con dos objetos datetime (desde, hasta)"""
        date_string1 = pickerinput[:10]
        date_string2 = pickerinput[13:]
        date_object1 = datetime.datetime.strptime(date_string1, "%d/%m/%Y")
        date_object2 = datetime.datetime.strptime(date_string2, "%d/%m/%Y")
        return (date_object1, date_object2)
