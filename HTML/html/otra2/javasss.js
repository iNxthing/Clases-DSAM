const hamb =
document.getElementById("hamb");


const menu =
document.getElementById("menu");


hamb.onclick=()=>{

menu.classList.toggle("active");

};






let imgs=[

"https://images.unsplash.com/photo-1542751371-adc38448a05e?w=900",

"https://images.unsplash.com/photo-1593305841991-05c297ba4575?w=900",

"https://images.unsplash.com/photo-1511512578047-dfb367046420?w=900"

];



let i=0;


setInterval(()=>{


i++;


if(i>=imgs.length){

i=0;

}


document.getElementById("slide").src=imgs[i];


},3000);