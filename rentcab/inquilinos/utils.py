import datetime
from re import template

from django.core.mail import EmailMultiAlternatives, send_mail
from django.template.loader import render_to_string
from django.utils.html import strip_tags


class CustomParser:
    def getParsedToday():
        """devuelve el día en string con formato mes día año"""
        today = datetime.date.today()
        # se pasa el día de hoy de datetime obj a str
        return today.strftime("%m-%d-%Y")


    def parseReservas(reservas):
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

    def parseRanges(ranges):
        allowed_dates = list()
        for range in ranges:
            bar = []
            bar.append(range.fechaDesde)
            bar.append(range.fechaHasta)
            allowed_dates.append(bar)

        return allowed_dates

    def parsePickerInput(pickerinput):
        """toma como argumento un string proveniente de un date range picker y devuelve
        una tupla con dos objetos datetime (desde, hasta)"""
        date_string1 = pickerinput[:10]
        date_string2 = pickerinput[13:]
        date_object1 = datetime.datetime.strptime(date_string1, "%d/%m/%Y")
        date_object2 = datetime.datetime.strptime(date_string2, "%d/%m/%Y")
        return (date_object1, date_object2)


class EmailSender:
    def mail_reserva(template_name, reserva):
        template = f"inquilinos/{template_name}"
        html_content = render_to_string(
            template,
            {
                "reserva": reserva,
            },
        )
        # se eliminan las etiquetas
        text_content = strip_tags(html_content)

        # se constrye el mail
        email = EmailMultiAlternatives(
            subject=f"Nueva Reserva Registrada #{reserva.pk}",  # asunto
            body=text_content,
            from_email=None,  # acá lo dejé en none para que se use el host definido en settings.py
            to=["samuel5848@gmail.com"],  # para, acá iria el mail de enc de reservas
        )

        # se define el tipo de representación del mail como text/html
        email.attach_alternative(html_content, "text/html")
        # se envía el mail al encargado de reservas
        email.send()
