const today = JSON.parse(document.getElementById('today').textContent);
const allowedDates = JSON.parse(document.getElementById('allowed_dates').textContent);
const disabledDates = JSON.parse(document.getElementById('disabled_dates').textContent);
const costoPorNoche = JSON.parse(document.getElementById('costoPorNoche').textContent);
const picker = new Litepicker({
	element: document.getElementById('litepicker'),
	singleMode: false,
	tooltipText: {
		one: 'noche',
		other: 'noches'
	},
	tooltipNumber: (totalDays) => {
		return totalDays - 1;
	},
	lockDays: disabledDates,
	format: "DD/MM/YYYY",
	lockDaysFormat: "DD/MM/YYYY",
	minDate: today,
	startDate: today,
	numberOfMonths: 2,
	numberOfColumns: 2,
	lang: 'es-AR',
	minDays: 2,
	disallowLockDaysInRange: true,
	lockDaysFilter: (date1, date2, pickedDates) => {
		if (!date2) {
			return !allowedDates.includes(date1.format('DD/MM/YYYY'));
		}
		while (date1.toJSDate() < date2.toJSDate()) {
			const day = date1.getDay();
			isProhibited = !allowedDates.includes(date1.format('DD/MM/YYYY'));
			if (isProhibited) {
				return true;
			}
			date1.add(1, 'day');
		}

		return false;
	},
	resetButton: true,
	setup: (picker) => {
		picker.on('selected', (date1, date2) => {
			let costo_por_noche = parseFloat(costoPorNoche);
			let precioFinal = (date2.diff(date1, 'days')) * costo_por_noche;
			updatePrecio(precioFinal);
		});
	},
});

function updatePrecio(precioFinal) {
	console.log(precioFinal);
	var ptag = document.getElementById('ptag');
	ptag.innerHTML = ''
	var text = document.createTextNode("Precio final: $" + precioFinal);
	ptag.appendChild(text);
};