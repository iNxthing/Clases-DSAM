const formulario =
document.getElementById("formulario");


formulario.addEventListener(
"submit",
(e)=>{


e.preventDefault();



let nombre =
document.getElementById("nombre").value.trim();


let correo =
document.getElementById("correo").value.trim();


let telefono =
document.getElementById("telefono").value.trim();


let servicio =
document.getElementById("servicio").value;


let mensaje =
document.getElementById("mensaje").value.trim();



let resultado =
document.getElementById("resultado");





if(
nombre==="" ||
correo==="" ||
telefono==="" ||
servicio==="Seleccione" ||
mensaje===""
){


resultado.innerHTML =
"Completa todos los campos";


resultado.className="error";


return;


}






resultado.innerHTML =
"Solicitud enviada correctamente ✔";


resultado.className="success";



formulario.reset();



});