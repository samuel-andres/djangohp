function validarFormulario(evento) {
  var email = document.getElementById('typeEmailX');
  console.log(email.value)
  if(validarEmail(email.value)) {
    email.classList.remove("campo-erroneo")
    email.classList.add("campo-correcto")
    return true;
  } else {
    console.log("erroneo pa")
    email.classList.remove("campo-correcto")
    email.classList.add("campo-erroneo");
    //console.log(email)
    //email.addEventListener("click", rehabilitarCampo)
    return false;
  }
}

function validarEmail(valor) {
  var emailRegex = /^[-\w.%+]{1,64}@(?:[A-Z0-9-]{1,63}\.){1,125}[A-Z]{2,63}$/i;
  if (emailRegex.test(valor)){
    console.log("bien")
    return true;	
  } else {
    console.log("mal")
    return false;
  }
}
