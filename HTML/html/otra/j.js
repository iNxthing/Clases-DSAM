const hamburger =
document.getElementById("hamburger");


const sidebar =
document.getElementById("sidebar");



hamburger.onclick=()=>{


sidebar.classList.toggle("active");


};






let reviews=[

"Excelente trabajo y diseño profesional",

"Proyecto rápido y moderno",

"Una experiencia increíble"

];


let i=0;


setInterval(()=>{


i++;


if(i>=reviews.length){

i=0;

}


document.getElementById("review").innerHTML =
reviews[i];


},2500);