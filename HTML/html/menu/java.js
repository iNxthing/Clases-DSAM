const hamburger = document.getElementById("hamburger");

const menu = document.getElementById("menu");


hamburger.addEventListener("click",()=>{


menu.classList.toggle("active");


});




// submenu en celular

const dropdowns = document.querySelectorAll(".dropdown");


dropdowns.forEach(drop => {


drop.addEventListener("click",()=>{


drop.classList.toggle("active");


});


});