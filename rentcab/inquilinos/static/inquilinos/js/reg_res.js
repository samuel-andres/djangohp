const today = JSON.parse(document.getElementById('today').textContent);
const allowedDates = JSON.parse(document.getElementById('allowed_dates').textContent);
const disabledDates = JSON.parse(document.getElementById('disabled_dates').textContent);
const costoPorNoche = JSON.parse(document.getElementById('costoPorNoche').textContent);

function getDatesInRange(startDate, endDate) {
	const date = new Date(startDate.getTime());

	const dates = [];

	while (date <= endDate) {
	  dates.push(new Date(date));
	  date.setDate(date.getDate() + 1);
	}

	return dates;
  }

let js_allowed_dates = [];
for (arr of allowedDates) {
	const d1 = new Date(arr[0]);
	d1.setDate(d1.getDate() + 1);
	d1.setHours(0, 0, 0, 0);
	const d2 = new Date(arr[1]);
	d2.setDate(d2.getDate() + 1)
	d2.setHours(0, 0, 0, 0);
	js_allowed_dates = js_allowed_dates.concat(getDatesInRange(d1, d2))
}

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
			return !js_allowed_dates.find(date => {
				return date.getTime() == date1.dateInstance.getTime()
				}
			);
		}
		while (date1.toJSDate() < date2.toJSDate()) {
			isProhibited = !js_allowed_dates.find(date => date.getTime() == date1.dateInstance.getTime())
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
	var ptag = document.getElementById('ptag');
	ptag.innerHTML = ''
	var text = document.createTextNode("Precio final: $" + precioFinal);
	ptag.appendChild(text);
};
