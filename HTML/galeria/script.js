const images =
document.querySelectorAll(".item img");


const modal =
document.getElementById("modal");


const modalImg =
document.getElementById("modalImg");


const close =
document.getElementById("close");




images.forEach(img=>{


img.onclick=()=>{


modal.style.display="flex";


modalImg.src=img.src;


}


});





close.onclick=()=>{


modal.style.display="none";


};





modal.onclick=(e)=>{


if(e.target===modal){

modal.style.display="none";

}


};