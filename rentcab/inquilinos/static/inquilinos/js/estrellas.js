let avgStars = JSON.parse(document.getElementById('calificacionPromedio').textContent);
let stars = '&#9733;';
for(var i = 0 ;i<(Math.round(avgStars))-1;i++)
{
  stars=stars+' &#9733;';
}
document.getElementById('estrellas').innerHTML = stars;

let coms = document.querySelectorAll('.star-place-holder')
for (let com of coms){
    let com_stars = '&#9733;';
    let count_stars = com.textContent;
    for (let i = 0 ;i<count_stars-1;){
        com_stars=com_stars+' &#9733;';
        i += 1;
    }
    com.innerHTML = com_stars;
}