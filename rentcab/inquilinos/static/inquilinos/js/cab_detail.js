// primero se chequea que el promedio es un número válido
if (!isNaN(parseFloat(document.getElementById('id_calificacionPromedio').textContent))) {
  // si lo es se guarda en la variable avgStars
  let avgStars = JSON.parse(document.getElementById('id_calificacionPromedio').textContent);
// se inicializa stars con el ascii code de una estrella
let stars = '&#9733;';
// se calcula el promedio y se generan las estrellas
for(var i = 0 ;i<(Math.round(avgStars))-1;i++)
{
  stars=stars+' &#9733;';
}
document.getElementById('id_Estrellas').innerHTML = stars;

// mismo cálculo para los comentarios
let coms = document.querySelectorAll('.star-place-holder')
for (let com of coms){
    let com_stars = '&#9733;';
    let count_stars = com.textContent;
    if (!isNaN(parseFloat(count_stars))){
      for (let i = 0 ;i<count_stars-1;){
        com_stars=com_stars+' &#9733;';
        i += 1;
    }
    com.innerHTML = com_stars;
    } else {
      com.innerHTML = '';
    }
}
} else {
  let li = document.getElementById('id_Calificacion');
  li.parentNode.removeChild(li);
}