// proteger página


if(localStorage.getItem("login")!=="true"){


window.location="login.html";


}





// cerrar sesión


function logout(){


localStorage.removeItem("login");


window.location="login.html";


}





// menu


const hamb =
document.getElementById("hamb");


const menu =
document.getElementById("menu");



hamb.onclick=()=>{


menu.classList.toggle("active");


};







// slider


let images=[


"https://images.unsplash.com/photo-1518770660439-4636190af475?w=900",


"https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=900",


"https://images.unsplash.com/photo-1555066931-4365d14bab8c?w=900"


];



let i=0;


setInterval(()=>{


i++;


if(i>=images.length){

i=0;

}



document.getElementById("slider")
.src=images[i];


},3000);