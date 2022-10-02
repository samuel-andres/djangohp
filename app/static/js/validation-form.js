//FUNCION PARA VALIDACION DEL CAMPO EMAIL
function validarFormulario(evento) {
  var email = document.getElementById('typeEmailX');
  var textoEmail = document.getElementById('text-email-error');
  if(email.value.length > 0) {
    if(validarEmail(email.value)) {
      colocarCampoCorrecto(email, textoEmail);
      return true;
    } else {
      colocarCampoErroneo(email, textoEmail);
      //console.log(email)
      //email.addEventListener("click", rehabilitarCampo)
      return false;
    }
  } 
}

//FUNCION PARA CAMBIAR ESTILOS DE LOS CAMPOS CORRECTOS
function colocarCampoCorrecto(campo, textoErrorCampo) {
  campo.classList.remove("campo-erroneo");
  campo.classList.add("campo-correcto");
  textoErrorCampo.style.display = "none";
}

//FUNCION PARA CAMBIAR ESTILOS DE CAMPOS ERRONEOS
function colocarCampoErroneo(campo, textoErrorCampo) {
  campo.classList.remove("campo-correcto")
  campo.classList.add("campo-erroneo");
  textoErrorCampo.classList.add("debil");
  textoErrorCampo.style.display = "flex";//hacemos aparecer el texto de error
}

//FUNCION PARA RESETEAR LOS ESTILOS DE LOS CAMPOS DEL FORM
function resetearEstilosCampos(campo, textoErrorCampo) {
  campo.classList.remove("campo-erroneo");
  campo.classList.remove("campo-correcto");
  textoErrorCampo.style.display = "none";
}

//FUNCION PARA VALIDACION DEL FORMATO DEL EMAIL
//Se valida el formato del email en base a una expresion regular
function validarEmail(valor) {
  var emailRegex = /^[-\w.%+]{1,64}@(?:[A-Z0-9-]{1,63}\.){1,125}[A-Z]{2,63}$/i;
  if (emailRegex.test(valor)){
    return true;	
  } else {
    return false;
  }
}

//FUNCION PARA VALIDACION DEL NOMBRE DE USUARIO
function validarUsuario() {
  var usuario = document.getElementById("typeUserX");
  var textoUsuario = document.getElementById("text-user-error");
  if(usuario.value.length > 3) {
    colocarCampoCorrecto(usuario, textoUsuario);
  }else if(usuario.value.length <= 3 && usuario.value.length > 0) {
    colocarCampoErroneo(usuario, textoUsuario);
  }else {
    resetearEstilosCampos(usuario, textoUsuario);
  }
}

//FUNCION QUE OBTIENE DATOS PARA VALIDAR LA CONTRASENA
function validarContrasena() {
  const indicator = document.querySelector(".indicator");
  const input = document.getElementById("typePasswordX");
  const debil = document.getElementById("debil");
  const media = document.querySelector(".media");
  const fuerte = document.querySelector(".fuerte");
  const text = document.querySelector(".text"); 
  const shwButton = document.querySelector(".shwButton");

  //validamos el campo de la contrasena repetida para verificar si son iguales
  validarPasswordRepetido();

  trigger(indicator, input, debil, media, fuerte, text, shwButton);
}

//FUNCTION PARA DETERMINAR EL GRADO DE SEGURIDAD DE LA CONTRASENA
function trigger(indicator, input, debil, media, fuerte, text, shwButton) {
  //Expresiones regulares
  let regExpDebil = /[a-z]/;//contrasena debil
  let regExpMedia = /\d+/;//contrasena media
  let regExpFuerte = /.[!,@,#,$,%,^,&,*,?,_,~,-,(,)]/;//contrasena fuerte

  if(input.value != "") {
    indicator.style.display = "block";
    indicator.style.display = "flex";   
    shwButton.style.display = "block";

    //Evento click del boton para mostrar la contrasena
    shwButton.onclick = verPaswword;

    var no;
    //Valicacion de la contrasena ingresada con las expresiones regulares
    if(input.value.match(regExpDebil) || input.value.match(regExpMedia) || input.value.match(regExpFuerte))no=1;
    if(input.value.length >= 6 && input.value.match(regExpDebil) && input.value.match(regExpMedia) || (input.value.match(regExpMedia) && input.value.match(regExpFuerte)) || (input.value.match(regExpDebil) && input.value.length >= 6 && input.value.match(regExpFuerte)))no=2;
    if(input.value.length >= 6 && input.value.match(regExpDebil) && input.value.match(regExpMedia) && input.value.match(regExpFuerte))no=3;

    //En base al valor de la variable no adquirido en los condicionales ateriores
    //determinamos el comportamiento del indicador del grado de seguridad
    
    //si la contrasena es categorizada como debil
    if(no == 1) { 
      cambiarGradoContrasena(debil, text, "debil", "Tu contraseña es muy debil.");
      input.classList.add("campo-correcto");//indicamos que el campo esta correcto !!
    }

    //si la contrasena es categorizada como media
    if(no == 2) {
      cambiarGradoContrasena(media, text, "media", "Tu contraseña es aceptable.")
    }else {
      media.classList.remove("active");
      text.classList.remove("media");
    }

    //si la contrasena es categorizada como fuertev
    if(no == 3) {
      media.classList.add("active");
      cambiarGradoContrasena(fuerte, text, "fuerte", "Tu contraseña es excelente.");
    } else {
      fuerte.classList.remove("active");
      text.classList.remove("fuerte");
    }
    
  }else { //si el campo esta vacio...
    debil.classList.remove("active");
    media.classList.remove("active");
    fuerte.classList.remove("active");
    input.classList.remove("campo-correcto");
    /*indicator.style.display = "none";*/
    text.style.display = "none";
    shwButton.style.display = "none";
  }
}

//FUNCION PARA CAMBIAR EL GRADO DE SEGURIDAD DE LA CONTRASENA Y MOSTRARLO
function cambiarGradoContrasena(campo, textoCampo, claseCampo, mensaje) {
  campo.classList.add("active");
  textoCampo.style.display = "block";
  textoCampo.textContent = mensaje;
  textoCampo.classList.add(claseCampo);
}

//FUNCION PARA PODER VER LA CONTRASENA INGRESADA
function verPaswword() {
  const input = document.getElementById("typePasswordX");
  if(input.type == "password"){
    input.type = "text";
  }else {
    input.type = "password";
  }
}

//FUNCION QUE VALIDA SI LAS CONTRASENAS INGRESADAS SON IGUALES
function validarPasswordRepetido() {
  var password1 = document.getElementById("typePasswordX");
  var password2 = document.getElementById("typePasswordX2");
  var textoPassword = document.getElementById("text-contra-error")
  if(password2.value.length > 0) {
    if (password1.value == password2.value) {
      colocarCampoCorrecto(password2, textoPassword);
    } else{
      colocarCampoErroneo(password2, textoPassword);
    }
  }else{
      resetearEstilosCampos(password2, textoPassword);
  }
    
}
