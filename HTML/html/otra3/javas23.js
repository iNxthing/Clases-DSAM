const form =
document.getElementById("loginForm");


const user =
document.getElementById("username");


const pass =
document.getElementById("password");


const message =
document.getElementById("message");





// mostrar contraseña

document
.getElementById("show")
.addEventListener("click",()=>{


if(pass.type==="password"){


pass.type="text";


}else{


pass.type="password";


}


});









form.addEventListener("submit",(e)=>{


e.preventDefault();



let username=user.value.trim();

let password=pass.value.trim();





if(username==="" || password===""){


message.innerHTML=
"Completa todos los campos";


message.className="error";


return;


}





// usuario de prueba


if(username==="admin" && password==="12345"){



localStorage.setItem(
"usuario",
username
);



message.innerHTML=
"Inicio correcto ✔";


message.className="success";



setTimeout(()=>{


window.location.href="home.html";


},1500);




}else{



message.innerHTML=
"Usuario o contraseña incorrectos";


message.className="error";



}




});