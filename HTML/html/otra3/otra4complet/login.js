const form =
document.getElementById("formLogin");


form.addEventListener("submit",(e)=>{


e.preventDefault();



let user =
document.getElementById("user").value;



let pass =
document.getElementById("pass").value;





if(user==="admin" && pass==="1234"){


localStorage.setItem(
"login",
"true"
);



window.location="home.html";



}else{


document.getElementById("msg")
.innerHTML="Datos incorrectos";


}


});