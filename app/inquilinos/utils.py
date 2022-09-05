import datetime
from re import template

from django.core.mail import EmailMultiAlternatives
from django.template.loader import render_to_string
from django.utils.html import strip_tags


class CustomParser:
    """Helper para custom parsing"""

    def parseRanges(queryset, formatear):
        """toma como argumento un queryset y devuelve una lista con los rangos de fechas
        desde hasta de cada objeto en forma de array"""
        date_ranges = list()
        if not formatear:
            for obj in queryset:
                bar = []
                bar.append(obj.fechaDesde)
                bar.append(obj.fechaHasta)
                date_ranges.append(bar)
        if formatear:
            for obj in queryset:
                bar = []
                bar.append(obj.fechaDesde.strftime("%d/%m/%Y"))
                bar.append(obj.fechaHasta.strftime("%d/%m/%Y"))
                date_ranges.append(bar)

        return date_ranges

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
