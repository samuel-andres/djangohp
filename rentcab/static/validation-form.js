document.addEventListener("DOMContentLoaded", function() {
  document.getElementById("registro-huesped").addEventListener('submit', validarFormulario); 
});

function validarFormulario(evento) {
  evento.preventDefault();
  var email = document.getElementById('typeEmailX').value;
  if(validarEmail(email)) {
    alert('Email correcto');
    return;
  } else {
    alert("Email incorrecto")
  }
}

function validarEmail(valor) {
  if (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3,4})+$/.test(valor)){
    return true;	
  } else {
    return false;
  }
}