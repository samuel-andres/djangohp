const allowedDates = JSON.parse(document.getElementById('allowed_dates').textContent);
const disabledDates = JSON.parse(document.getElementById('disabled_dates').textContent);
const costoPorAdulto = JSON.parse(document.getElementById('costoPorAdulto').textContent);
const costoPorMenor = JSON.parse(document.getElementById('costoPorMenor').textContent);
const cantMenoresElement = document.getElementById('id_cantMenores');
const cantAdultosElement = document.getElementById('id_cantAdultos');
const masAdultosBtn = document.getElementById('btn-mas-ad');
const menAdultosBtn = document.getElementById('btn-men-ad');
const masMenoresBtn = document.getElementById('btn-mas-men');
const menMenoresBtn = document.getElementById('btn-men-men');
const MIN_CANT_MENORES = 0;
const MIN_CANT_ADULTOS = 0;
const MAX_CANT_PERSONAS = 5;

if(!cantAdultosElement.value){
	cantAdultosElement.value = 1;
}

if (!cantMenoresElement.value){
	cantMenoresElement.value = 1;
}

masAdultosBtn.addEventListener('click', () => {
	let actual = Number(cantAdultosElement.value);
	if (actual + Number(cantMenoresElement.value) < MAX_CANT_PERSONAS) {
		cantAdultosElement.value = actual + 1;
		cantAdultos = cantAdultosElement.value;
		updatePrecio();
	};
});

menAdultosBtn.addEventListener('click', () => {
	let actual = Number(cantAdultosElement.value);
	if (actual > 1) {
		cantAdultosElement.value = actual - 1;
		cantAdultos = cantAdultosElement.value;
		updatePrecio();
	};
});

masMenoresBtn.addEventListener('click', () => {
	let actual = Number(cantMenoresElement.value);
	if (actual + Number(cantAdultosElement.value) < MAX_CANT_PERSONAS) {
		cantMenoresElement.value = actual + 1;
		cantMenores = cantMenoresElement.value;
		updatePrecio();
	};
});

menMenoresBtn.addEventListener('click', () => {
	let actual = Number(cantMenoresElement.value);
	if (actual > 0) {
		cantMenoresElement.value = actual - 1;
		cantMenores = cantMenoresElement.value;
		updatePrecio();
	};
});


let TODAY = new Date()



TODAY.setDate(TODAY.getDate() - 1);
let precioFinal = 0;
let cantNoches = 0;
let cantAdultos = 1;
let cantMenores = 0;
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
	minDate: TODAY,
	startDate: TODAY,
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
			cantNoches =  (date2.diff(date1, 'days'))
			updatePrecio(cantNoches);
		});
	},
});

function updatePrecio() {
	precioFinal = cantNoches * ((cantAdultos * costoPorAdulto) + (cantMenores * costoPorMenor))
	// console.log('noches', cantNoches, 'adultos', cantAdultos, 'menores', cantMenores, 'costoAdulto', costoPorAdulto, 'costoPorMenor', costoPorMenor)
	var ptag = document.getElementById('ptag');
	ptag.innerHTML = ''
	var text = document.createTextNode("Precio final: $" + precioFinal);
	ptag.appendChild(text);
};

cantAdultosElement.addEventListener('change', () => {
	cantAdultos = cantAdultosElement.value;
	updatePrecio()
});
cantMenoresElement.addEventListener('change', () => {
	cantMenores = cantMenoresElement.value;
	updatePrecio();
});