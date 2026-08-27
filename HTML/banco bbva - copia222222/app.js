const menu =
document.getElementById("menu");


const hamb =
document.getElementById("hamb");



hamb.onclick=()=>{

menu.classList.toggle("active");

};






const slides=[


{

img:
"https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=1600",

title:
"Ya hay 30 ganadores.",

text:
"Súmate al sorteo del mes y participa."

},




{

img:
"https://images.unsplash.com/photo-1563013544-824ae1b704d3?w=1600",

title:
"Tu banco en el bolsillo",

text:
"Controla todo desde tu celular."

},





{

img:
"https://images.unsplash.com/photo-1551836022-d5d88e9218df?w=1600",

title:
"Créditos para tus sueños",

text:
"Solicita financiación fácil."

}


];




let index=0;



function showSlide(){


document.getElementById("bannerImage")
.src=slides[index].img;



document.getElementById("bannerTitle")
.innerHTML=slides[index].title;



document.getElementById("bannerText")
.innerHTML=slides[index].text;




let dots =
document.querySelectorAll(".dots span");


dots.forEach(d=>d.classList.remove("active"));


dots[index].classList.add("active");


}





function nextSlide(){


index++;


if(index>=slides.length)
index=0;


showSlide();


}





function prevSlide(){


index--;


if(index<0)
index=slides.length-1;


showSlide();


}






setInterval(nextSlide,5000);