// contexto
const fechasHabilitadas = JSON.parse(
  document.getElementById("id_fechasHabilitadas").textContent
);
const fechasDeshabilitadas = JSON.parse(
  document.getElementById("id_fechasDeshabilitadas").textContent
);
const costoPorAdulto = JSON.parse(
  document.getElementById("id_costoPorAdulto").textContent
);
const costoPorMenor = JSON.parse(
  document.getElementById("id_costoPorMenor").textContent
);
const MAX_CANT_PERSONAS = JSON.parse(
  document.getElementById("id_cantMaxPersonas").textContent
);
// campos dinamicos
const cantMenoresElement = document.getElementById("id_cantMenores");
const cantAdultosElement = document.getElementById("id_cantAdultos");
// botones
const masAdultosBtn = document.getElementById("btn-mas-ad");
const menAdultosBtn = document.getElementById("btn-men-ad");
const masMenoresBtn = document.getElementById("btn-mas-men");
const menMenoresBtn = document.getElementById("btn-men-men");
// constantes
const MIN_CANT_MENORES = 0;
const MIN_CANT_ADULTOS = 1;
let TODAY = new Date();
TODAY.setDate(TODAY.getDate() - 1);
// valores iniciales
let precioFinal = 0;
let cantNoches = 0;
let cantAdultos = 1;
let cantMenores = 0;

// setea el valor inicial de la cantidad de adultos a 1
if (!cantAdultosElement.value) {
  cantAdultosElement.value = cantAdultos;
}

// setea el valor inicial de la cantidad de menores a 1
if (!cantMenoresElement.value) {
  cantMenoresElement.value = cantMenores;
}

const sumarAdulto = () => {
  /**
   * Funcion que obtiene el valor actual de la cantidad de adultos y si
   * este valor es menor a la cantidad maxima de personas suma 1, además,
   * si la cantidad de menores sumado a la cantidad de adultos antes de
   * realizar la suma es igual a la cantida máxima de personas, resta
   * uno a la cantidad de menores
   */
  let actual = Number(cantAdultosElement.value);
  if (actual + Number(cantMenoresElement.value) == MAX_CANT_PERSONAS) {
    restarMenor();
  }
  if (actual + Number(cantMenoresElement.value) < MAX_CANT_PERSONAS) {
    cantAdultosElement.value = actual + 1;
    cantAdultos = cantAdultosElement.value;
    updatePrecio();
  }
};

const restarAdulto = () => {
  /**
   * Función que resta un adulto
   */
  let actual = Number(cantAdultosElement.value);
  if (actual > 1) {
    cantAdultosElement.value = actual - 1;
    cantAdultos = cantAdultosElement.value;
    updatePrecio();
  }
};

const sumarMenor = () => {
  /**
   * Función equivalente a sumarAdulto pero con menores
   */
  let actual = Number(cantMenoresElement.value);
  if (actual + Number(cantAdultosElement.value) == MAX_CANT_PERSONAS) {
    restarAdulto();
  }
  if (actual + Number(cantAdultosElement.value) < MAX_CANT_PERSONAS) {
    cantMenoresElement.value = actual + 1;
    cantMenores = cantMenoresElement.value;
    updatePrecio();
  }
};

const restarMenor = () => {
  /**
   * Función equivalente a restarAdulto pero con menores
   */
  let actual = Number(cantMenoresElement.value);
  if (actual > 0) {
    cantMenoresElement.value = actual - 1;
    cantMenores = cantMenoresElement.value;
    updatePrecio();
  }
};

// helper para obtener fechas a partir de un rango dado (tipo Date)
function getDatesInRange(startDate, endDate) {
  const date = new Date(startDate.getTime());
  const dates = [];
  while (date <= endDate) {
    dates.push(new Date(date));
    date.setDate(date.getDate() + 1);
  }
  return dates;
}

// se parsea la lista de rangos de disponibilidad de
// string a Date, generando js_fechasHabilitadas: Date[][]

let js_fechasHabilitadas = [];
for (arr of fechasHabilitadas) {
  const d1 = new Date(arr[0]);
  d1.setDate(d1.getDate() + 1);
  d1.setHours(0, 0, 0, 0);
  const d2 = new Date(arr[1]);
  d2.setDate(d2.getDate() + 1);
  d2.setHours(0, 0, 0, 0);
  js_fechasHabilitadas = js_fechasHabilitadas.concat(getDatesInRange(d1, d2));
}

// definición del litepicker y configuración
const picker = new Litepicker({
  element: document.getElementById("litepicker"),
  singleMode: false,
  tooltipText: {
    one: "noche",
    other: "noches",
  },
  tooltipNumber: (totalDays) => {
    return totalDays - 1;
  },
  lockDays: fechasDeshabilitadas,
  format: "DD/MM/YYYY",
  lockDaysFormat: "DD/MM/YYYY",
  minDate: TODAY,
  startDate: TODAY,
  numberOfMonths: 2,
  numberOfColumns: 2,
  lang: "es-AR",
  minDays: 2,
  disallowLockDaysInRange: true,
  lockDaysFilter: (date1, date2, pickedDates) => {
    if (!date2) {
      return !js_fechasHabilitadas.find((date) => {
        return date.getTime() == date1.dateInstance.getTime();
      });
    }
    while (date1.toJSDate() < date2.toJSDate()) {
      isProhibited = !js_fechasHabilitadas.find(
        (date) => date.getTime() == date1.dateInstance.getTime()
      );
      if (isProhibited) {
        return true;
      }
      date1.add(1, "day");
    }

    return false;
  },
  resetButton: true,
  setup: (picker) => {
    picker.on("selected", (date1, date2) => {
      cantNoches = date2.diff(date1, "days");
      updatePrecio(cantNoches);
    });
  },
});

function updatePrecio() {
  /**
   * funcion que calcula y actualiza el precio en los elementos correspondientes en base
   * a los datos que se encuentran en las variables:
   * precioFinal, cantNoches, cantAdultos, costoPorAdulto, cantMenores y costoPorMenor
   */
  precioFinal =
    cantNoches * (cantAdultos * costoPorAdulto + cantMenores * costoPorMenor);
  var ptag = document.getElementById("ptag");
  ptag.innerHTML = "";
  if (!!precioFinal) {
    var text = document.createTextNode("Precio final: $" + precioFinal);
    ptag.appendChild(text);
  }
}

// event listeners
// a cada boton se asigna el callback correspondiente
masAdultosBtn.addEventListener("click", sumarAdulto);
menAdultosBtn.addEventListener("click", restarAdulto);
masMenoresBtn.addEventListener("click", sumarMenor);
menMenoresBtn.addEventListener("click", restarMenor);

cantAdultosElement.addEventListener("change", () => {
  cantAdultos = cantAdultosElement.value;
  updatePrecio();
});

cantMenoresElement.addEventListener("change", () => {
  cantMenores = cantMenoresElement.value;
  updatePrecio();
});
