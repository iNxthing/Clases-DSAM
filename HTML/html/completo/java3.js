const hamburger =
document.getElementById("hamburger");


const menu =
document.getElementById("menu");



hamburger.onclick=()=>{

menu.classList.toggle("active");

};





const images=[

"https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=900",

"https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=900",

"https://images.unsplash.com/photo-1555066931-4365d14bab8c?w=900"

];



let index=0;


setInterval(()=>{


index++;


if(index>=images.length){

index=0;

}


document.getElementById("slider").src=images[index];


},3500);