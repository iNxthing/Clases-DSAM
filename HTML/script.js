/* =========================================================
   Elementos que JavaScript necesita controlar
   Se guardan en constantes para no repetir busquedas en el DOM
   cada vez que se abre el menu o cambia el slider.
========================================================= */
const menuToggle = document.getElementById('menuToggle');
const menu = document.getElementById('menu');
const sliderImage = document.getElementById('sliderImage');
const prevSlide = document.getElementById('prevSlide');
const nextSlide = document.getElementById('nextSlide');

/*
   Lista de imagenes del slider.
   Para usar imagenes propias, reemplaza estas rutas por archivos locales,
   por ejemplo: 'img/banner-1.jpg'.
*/
const imagenes = [
    'wp13674951-tv-girl-pc-wallpapers.jpg',
    'https://picsum.photos/1100/700?random=20',
    'https://picsum.photos/1100/700?random=21',
    'https://picsum.photos/1100/700?random=22'
];

let imagenActual = 0;

/* =========================================================
   Slider de imagenes
   Esta funcion recibe el indice que se quiere mostrar. El calculo
   con modulo permite que el slider vuelva al inicio al pasar la
   ultima imagen, y tambien que retroceda desde la primera a la ultima.
========================================================= */
function mostrarImagen(indice) {
    imagenActual = (indice + imagenes.length) % imagenes.length;

    /*
       Se baja la opacidad antes de cambiar el src para que el cambio
       no sea tan brusco visualmente.
    */
    sliderImage.style.opacity = '0';

    setTimeout(() => {
        sliderImage.src = imagenes[imagenActual];
        sliderImage.style.opacity = '1';
    }, 180);
}

prevSlide.addEventListener('click', () => {
    mostrarImagen(imagenActual - 1);
});

nextSlide.addEventListener('click', () => {
    mostrarImagen(imagenActual + 1);
});

/*
   Cambio automatico:
   mantiene el banner vivo aunque el usuario no pulse los botones.
   El tiempo esta en milisegundos: 6000 equivale a 6 segundos.
*/
setInterval(() => {
    mostrarImagen(imagenActual + 1);
}, 6000);

/* =========================================================
   Menu responsive
   En CSS el menu movil esta oculto. Aqui solo se agrega o quita
   la clase .activo, dejando que CSS controle la presentacion.
========================================================= */
menuToggle.addEventListener('click', () => {
    const estaAbierto = menu.classList.toggle('activo');

    menuToggle.classList.toggle('activo', estaAbierto);
    menuToggle.setAttribute('aria-expanded', estaAbierto);
    menuToggle.setAttribute('aria-label', estaAbierto ? 'Cerrar menu' : 'Abrir menu');
});

/*
   Al tocar un enlace del menu en movil, se cierra automaticamente.
   Esto evita que el menu quede tapando la seccion a la que navegaste.
*/
menu.addEventListener('click', (event) => {
    if (event.target.classList.contains('item-menu')) {
        menu.classList.remove('activo');
        menuToggle.classList.remove('activo');
        menuToggle.setAttribute('aria-expanded', 'false');
        menuToggle.setAttribute('aria-label', 'Abrir menu');
    }
});
