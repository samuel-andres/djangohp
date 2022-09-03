function validarFormulario(evento) {
  var email = document.getElementById('typeEmailX');
  if(validarEmail(email.value)) {
    email.classList.remove("campo-erroneo")
    email.classList.add("campo-correcto")
    return true;
  } else {
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
    return true;	
  } else {
    return false;
  }
}

function validarUsuario() {
  var inputUsuario = document.getElementById("typeUserX");
  if(inputUsuario.value.length > 3) {
    inputUsuario.classList.remove("campo-erroneo");
    inputUsuario.classList.add("campo-correcto");
  }else if(inputUsuario.value.length <= 3 && inputUsuario.value.length > 0) {
    inputUsuario.classList.remove("campo-correcto");
    inputUsuario.classList.add("campo-erroneo");
  }else {
    inputUsuario.classList.remove("campo-erroneo");
    inputUsuario.classList.remove("campo-correcto");
  }
}

function validarContrasena() {
  const indicator = document.querySelector(".indicator");
  const input = document.getElementById("typePasswordX");
  const debil = document.querySelector(".debil");
  const media = document.querySelector(".media");
  const fuerte = document.querySelector(".fuerte");
  const text = document.querySelector(".text"); 
  const shwButton = document.querySelector(".shwButton");

  //validamos el campo de la contrasena repetida
  validarPasswordRepetido();

  trigger(indicator, input, debil, media, fuerte, text, shwButton);
}

function trigger(indicator, input, debil, media, fuerte, text, shwButton) {
  let regExpDebil = /[a-z]/;
  let regExpMedia = /\d+/;
  let regExpFuerte = /.[!,@,#,$,%,^,&,*,?,_,~,-,(,)]/;

  if(input.value != "") {
    indicator.style.display = "block";
    indicator.style.display = "flex";   
    shwButton.style.display = "block";

    shwButton.onclick = function() {
    if(input.type == "password"){
      input.type = "text";
    }else {
      input.type = "password";
      }
    }

    var no;

    if(input.value.match(regExpDebil) || input.value.match(regExpMedia) || input.value.match(regExpFuerte))no=1;
    if(input.value.length >= 6 && input.value.match(regExpDebil) && input.value.match(regExpMedia) || (input.value.match(regExpMedia) && input.value.match(regExpFuerte)) || (input.value.match(regExpDebil) && input.value.length >= 6 && input.value.match(regExpFuerte)))no=2;
    if(input.value.length >= 6 && input.value.match(regExpDebil) && input.value.match(regExpMedia) && input.value.match(regExpFuerte))no=3;

    if(no == 1) {
      debil.classList.add("active");
      text.style.display = "block";
      text.textContent = "Tu contraseña es muy debil."
      text.classList.add("debil");
      input.classList.add("campo-correcto");
    }

    if(no == 2) {
      media.classList.add("active");
      text.style.display = "block";
      text.textContent = "Tu contraseña es aceptable."
      text.classList.add("media");
    }else {
      media.classList.remove("active");
      text.classList.remove("media");
    }

    if(no == 3) {
      media.classList.add("active");
      fuerte.classList.add("active");
      text.textContent = "Tu contraseña es excelente."
      text.classList.add("fuerte");
    } else {
      fuerte.classList.remove("active");
      text.classList.remove("fuerte");
    }
    
  }else {
    debil.classList.remove("active");
    media.classList.remove("active");
    fuerte.classList.remove("active");
    /*indicator.style.display = "none";*/
    text.style.display = "none";
    shwButton.style.display = "none";
  }
}

function verPaswword() {
  var fieldPassword = document.querySelector("typePasswordX");
  fieldPassword.type = "text";
}

function validarPasswordRepetido() {
  var password1 = document.getElementById("typePasswordX");
  var password2 = document.getElementById("typePasswordX2");

  if (password1.value == password2.value) {
    password2.classList.remove("campo-erroneo");
    password2.classList.add("campo-correcto");
  } else{
    password2.classList.remove("campo-correcto");
    password2.classList.add("campo-erroneo");
  }
}
