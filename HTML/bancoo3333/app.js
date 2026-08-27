const images=[


"https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=1600",


"https://images.unsplash.com/photo-1563013544-824ae1b704d3?w=1600",


"https://images.unsplash.com/photo-1551836022-d5d88e9218df?w=1600"


];


let index=0;



function show(){


document.getElementById("slide")
.src=images[index];


}




function next(){

index++;

if(index>=images.length)
index=0;


show();

}




function prev(){

index--;

if(index<0)
index=images.length-1;


show();


}



setInterval(next,5000);