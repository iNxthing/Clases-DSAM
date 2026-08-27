if(localStorage.getItem("session")!=="active"){

location="login.html";

}




function logout(){


localStorage.removeItem("session");


location="login.html";


}




const hamb =
document.getElementById("hamb");


const menu =
document.getElementById("menu");



hamb.onclick=()=>{

menu.classList.toggle("active");

};






let fotos=[

"https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=900",

"https://images.unsplash.com/photo-1563013544-824ae1b704d3?w=900"

];



let i=0;


setInterval(()=>{


i++;


if(i>=fotos.length)
i=0;



document.getElementById("slider").src=fotos[i];


},4000);