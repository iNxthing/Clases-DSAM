const login =
document.getElementById("login");


login.addEventListener("submit",(e)=>{


e.preventDefault();


let user =
document.getElementById("usuario").value;


let pass =
document.getElementById("clave").value;



if(user==="cliente" && pass==="1234"){


localStorage.setItem(
"session",
"active"
);


location="index.html";



}else{


document.getElementById("error")
.innerHTML="Datos incorrectos";


}


});