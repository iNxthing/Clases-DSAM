# Guia explicada: menu hamburguesa, slider y Flexbox

Esta guia esta escrita para estudiar. La idea es explicar con calma como funciona cada parte, sin llenar el archivo de decoraciones innecesarias. Los dibujos aparecen solo cuando ayudan a visualizar algo.

## 1. La idea base: HTML, CSS y JavaScript

Cuando haces una pagina, normalmente trabajas con tres capas:

HTML crea la estructura. Por ejemplo, crea un boton, un menu, una imagen o una seccion.

CSS decide como se ve esa estructura. Por ejemplo, si el menu esta en fila o en columna, si el boton tiene fondo azul, si una imagen ocupa todo el ancho o si algo esta oculto.

JavaScript agrega comportamiento. Por ejemplo, cuando haces click en el boton hamburguesa, JavaScript puede agregar una clase para abrir el menu. Cuando haces click en el boton del slider, JavaScript puede cambiar la imagen.

Ejemplo simple:

```html
<button id="menuToggle">Menu</button>
```

Ese HTML solo crea un boton. Todavia no dice como se ve ni que hace.

```css
button {
    background: blue;
    color: white;
}
```

Ese CSS hace que el boton se vea azul con texto blanco.

```js
menuToggle.addEventListener('click', () => {
    console.log('click en el boton');
});
```

Ese JavaScript hace que el boton responda cuando alguien lo toca.

La regla mental importante es esta: HTML crea, CSS presenta, JavaScript reacciona.

## 2. Menu hamburguesa responsive

Un menu hamburguesa se usa normalmente en pantallas pequenas. En escritorio hay espacio para mostrar todos los enlaces en una fila:

```txt
BBVA                       Inicio  Productos  Servicios  Galeria  Contacto
```

En movil no hay tanto espacio. Si intentas mostrar todos los enlaces, se pueden apretar o romper el diseño:

```txt
BBVA Inicio Productos Servicios Galeria Contacto
```

Por eso se muestra un boton hamburguesa:

```txt
BBVA                                            [menu]
```

Cuando el usuario toca ese boton, aparece el menu vertical:

```txt
BBVA                                            [cerrar]

Inicio
Productos
Servicios
Galeria
Contacto
```

### 2.1. HTML del menu

El HTML de tu menu tiene esta idea:

```html
<header class="site-header">
    <a class="logo-header" href="#inicio">BBVA</a>

    <button class="menu-toggle" id="menuToggle" type="button" aria-label="Abrir menu" aria-expanded="false">
        <span></span>
        <span></span>
        <span></span>
    </button>

    <nav class="navegacion" id="menu">
        <a class="item-menu" href="#inicio">Inicio</a>
        <a class="item-menu" href="#productos">Productos</a>
        <a class="item-menu" href="#servicios">Servicios</a>
        <a class="item-menu" href="#galeria">Galeria</a>
        <a class="item-menu btn-menu" href="#contacto">Contacto</a>
    </nav>
</header>
```

Hay tres partes principales.

Primero esta el logo:

```html
<a class="logo-header" href="#inicio">BBVA</a>
```

Despues esta el boton hamburguesa:

```html
<button class="menu-toggle" id="menuToggle">
    <span></span>
    <span></span>
    <span></span>
</button>
```

Y por ultimo esta el menu real:

```html
<nav class="navegacion" id="menu">
    ... enlaces ...
</nav>
```

El boton hamburguesa no es el menu. El boton solo sirve para abrir o cerrar el `nav`. El menu real es el `nav`.

### 2.2. Por que el boton tiene tres `span`

El boton tiene tres `span` porque cada uno representa una linea del icono hamburguesa:

```html
<span></span>
<span></span>
<span></span>
```

Visualmente la idea es esta:

```txt
linea 1
linea 2
linea 3
```

Pero los `span` vacios no se ven por si solos. Por eso CSS les da tamaño y color:

```css
.menu-toggle span {
    display: block;
    width: 24px;
    height: 3px;
    margin: 5px auto;
    border-radius: 99px;
    background: #fff;
}
```

`display: block` hace que cada `span` se coloque en una linea separada.

`width: 24px` define el largo de la linea.

`height: 3px` define el grosor.

`margin: 5px auto` separa las lineas y las centra.

`background: #fff` les da color blanco.

### 2.3. Menu en escritorio

En escritorio, el header usa Flexbox:

```css
.site-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
}
```

Esto hace que el logo y el menu se acomoden en una fila. `justify-content: space-between` manda un elemento hacia la izquierda y otro hacia la derecha.

```txt
BBVA                                      Menu de enlaces
```

`align-items: center` los centra verticalmente dentro del header.

En escritorio el boton hamburguesa esta oculto:

```css
.menu-toggle {
    display: none;
}
```

El menu se ve horizontal porque `.navegacion` tiene `display: flex`:

```css
.navegacion {
    display: flex;
    align-items: center;
    gap: 8px;
}
```

Resultado:

```txt
Inicio  Productos  Servicios  Galeria  Contacto
```

### 2.4. Menu en movil

En movil se cambia el comportamiento con una media query:

```css
@media (max-width: 900px) {
    .menu-toggle {
        display: block;
    }

    .navegacion {
        position: absolute;
        top: calc(100% + 10px);
        left: 0;
        right: 0;
        display: none;
        flex-direction: column;
        align-items: stretch;
        padding: 16px;
        border-radius: 22px;
        background: #001391;
    }

    .navegacion.activo {
        display: flex;
    }
}
```

Cuando la pantalla mide 900px o menos, el boton hamburguesa aparece porque cambia a `display: block`.

El menu se oculta porque `.navegacion` tiene `display: none`.

Pero hay una regla especial:

```css
.navegacion.activo {
    display: flex;
}
```

Eso significa que cuando el `nav` tenga las clases `navegacion` y `activo` al mismo tiempo, se va a mostrar.

Sin abrir:

```html
<nav class="navegacion">
```

Abierto:

```html
<nav class="navegacion activo">
```

Ese es el truco principal del menu hamburguesa: el menu siempre existe en el HTML, pero CSS lo oculta o lo muestra dependiendo de si tiene la clase `activo`.

### 2.5. JavaScript del menu

JavaScript primero busca los elementos que necesita controlar:

```js
const menuToggle = document.getElementById('menuToggle');
const menu = document.getElementById('menu');
```

`menuToggle` representa el boton hamburguesa.

`menu` representa el `nav` con los enlaces.

Despues se escucha el click sobre el boton:

```js
menuToggle.addEventListener('click', () => {
    const estaAbierto = menu.classList.toggle('activo');

    menuToggle.classList.toggle('activo', estaAbierto);
    menuToggle.setAttribute('aria-expanded', estaAbierto);
    menuToggle.setAttribute('aria-label', estaAbierto ? 'Cerrar menu' : 'Abrir menu');
});
```

La linea mas importante es esta:

```js
const estaAbierto = menu.classList.toggle('activo');
```

`toggle` funciona como un interruptor. Si el menu no tiene la clase `activo`, se la agrega. Si ya la tiene, se la quita.

Ejemplo:

```txt
Primer click:
class="navegacion" pasa a class="navegacion activo"

Segundo click:
class="navegacion activo" pasa a class="navegacion"
```

JavaScript no dibuja el menu. JavaScript solo cambia una clase. CSS es quien decide que hacer visualmente con esa clase.

### 2.6. Cerrar el menu al tocar un enlace

Tambien tienes esta parte:

```js
menu.addEventListener('click', (event) => {
    if (event.target.classList.contains('item-menu')) {
        menu.classList.remove('activo');
        menuToggle.classList.remove('activo');
        menuToggle.setAttribute('aria-expanded', 'false');
        menuToggle.setAttribute('aria-label', 'Abrir menu');
    }
});
```

Esto sirve para que cuando pulses un enlace del menu en movil, el menu se cierre automaticamente.

`event.target` es el elemento exacto que recibio el click.

Esta condicion:

```js
event.target.classList.contains('item-menu')
```

pregunta si el elemento clickeado tiene la clase `item-menu`. Si la tiene, se cierra el menu.

Esto evita que el menu quede abierto tapando la seccion a la que acabas de navegar.

### 2.7. Animacion de hamburguesa a X

Cuando el boton tiene la clase `activo`, CSS transforma las lineas:

```css
.menu-toggle.activo span:nth-child(1) {
    transform: translateY(8px) rotate(45deg);
}

.menu-toggle.activo span:nth-child(2) {
    opacity: 0;
}

.menu-toggle.activo span:nth-child(3) {
    transform: translateY(-8px) rotate(-45deg);
}
```

La primera linea baja y rota.

La segunda linea desaparece.

La tercera linea sube y rota.

No se crea una X nueva. Se transforman las mismas tres lineas.

## 3. Slider o banner de imagenes

Un slider permite mostrar varias imagenes en un solo espacio. En lugar de poner cuatro imagenes una debajo de otra, tienes una sola imagen visible y botones para cambiarla.

La idea visual es esta:

```txt
[ boton anterior ]  [ imagen visible ]  [ boton siguiente ]
```

### 3.1. HTML del slider

Tu slider tiene esta estructura:

```html
<div class="slider" aria-label="Banner de imagenes">
    <button class="slider-btn prev" id="prevSlide" type="button" aria-label="Imagen anterior">&#10094;</button>

    <img id="sliderImage" src="wp13674951-tv-girl-pc-wallpapers.jpg" alt="Imagen destacada del banner">

    <button class="slider-btn next" id="nextSlide" type="button" aria-label="Imagen siguiente">&#10095;</button>
</div>
```

El `div.slider` es el marco del banner.

El boton `prevSlide` sirve para ir a la imagen anterior.

La imagen `sliderImage` es la imagen que cambia.

El boton `nextSlide` sirve para ir a la siguiente imagen.

Una cosa importante: solo hay una etiqueta `img`. JavaScript no crea muchas imagenes. Lo que hace es cambiar el valor del atributo `src` de esa misma imagen.

### 3.2. CSS del contenedor del slider

```css
.slider {
    position: relative;
    min-height: 430px;
    overflow: hidden;
    border-radius: 28px;
    background: #07123d;
}
```

`position: relative` es importante porque los botones del slider usan `position: absolute`. Cuando un elemento absoluto esta dentro de un contenedor relativo, se posiciona tomando ese contenedor como referencia.

`min-height: 430px` le da altura al banner.

`overflow: hidden` oculta lo que se salga del contenedor. Esto es util porque las imagenes pueden ser mas grandes que el marco.

`border-radius` redondea las esquinas.

### 3.3. CSS de la imagen

```css
.slider img {
    height: 430px;
    object-fit: cover;
    transition: opacity 0.25s ease;
}
```

`height: 430px` hace que la imagen tenga la misma altura que el banner.

`object-fit: cover` hace que la imagen cubra el espacio sin deformarse. Puede recortar un poco la imagen, pero evita que se vea estirada o aplastada.

`transition: opacity` permite hacer un cambio suave cuando JavaScript baja y sube la opacidad.

### 3.4. CSS de los botones del slider

```css
.slider-btn {
    position: absolute;
    top: 50%;
    z-index: 2;
    width: 46px;
    height: 46px;
    border-radius: 50%;
    transform: translateY(-50%);
}

.prev {
    left: 16px;
}

.next {
    right: 16px;
}
```

`position: absolute` permite poner los botones encima de la imagen.

`top: 50%` coloca el boton a la mitad vertical del slider.

`transform: translateY(-50%)` corrige el centrado. Sin eso, la esquina superior del boton quedaria en el centro. Con eso, el centro del boton queda en el centro.

`.prev` lo pega a la izquierda.

`.next` lo pega a la derecha.

### 3.5. JavaScript del slider

Primero se buscan los elementos:

```js
const sliderImage = document.getElementById('sliderImage');
const prevSlide = document.getElementById('prevSlide');
const nextSlide = document.getElementById('nextSlide');
```

Luego se define una lista de imagenes:

```js
const imagenes = [
    'wp13674951-tv-girl-pc-wallpapers.jpg',
    'https://picsum.photos/1100/700?random=20',
    'https://picsum.photos/1100/700?random=21',
    'https://picsum.photos/1100/700?random=22'
];
```

Esto es un array. Un array es una lista ordenada. En JavaScript, la primera posicion es `0`.

```txt
imagenes[0] = primera imagen
imagenes[1] = segunda imagen
imagenes[2] = tercera imagen
imagenes[3] = cuarta imagen
```

Despues se guarda cual imagen esta activa:

```js
let imagenActual = 0;
```

Si `imagenActual` vale `0`, se muestra la primera imagen. Si vale `1`, se muestra la segunda.

### 3.6. Funcion para mostrar una imagen

```js
function mostrarImagen(indice) {
    imagenActual = (indice + imagenes.length) % imagenes.length;

    sliderImage.style.opacity = '0';

    setTimeout(() => {
        sliderImage.src = imagenes[imagenActual];
        sliderImage.style.opacity = '1';
    }, 180);
}
```

Esta funcion recibe un indice y cambia la imagen visible.

La linea que cambia la imagen es esta:

```js
sliderImage.src = imagenes[imagenActual];
```

Eso cambia el `src` de la etiqueta `img`.

Ejemplo:

```html
<img src="imagen-1.jpg">
```

pasa a:

```html
<img src="imagen-2.jpg">
```

La etiqueta es la misma. Solo cambia la ruta.

### 3.7. Por que se usa `%`

Esta linea es la mas rara al principio:

```js
imagenActual = (indice + imagenes.length) % imagenes.length;
```

Sirve para que el slider no se salga de la lista.

Si hay cuatro imagenes, los indices validos son:

```txt
0, 1, 2, 3
```

Si estas en la imagen 3 y das siguiente, el indice seria 4. Pero `imagenes[4]` no existe. Con modulo pasa esto:

```txt
4 % 4 = 0
```

Entonces vuelve al inicio.

Si estas en la imagen 0 y das anterior, el indice seria -1. La formula lo convierte en 3:

```txt
(-1 + 4) % 4 = 3
```

Entonces puedes ir hacia atras desde la primera imagen y llegar a la ultima.

### 3.8. Botones anterior y siguiente

```js
prevSlide.addEventListener('click', () => {
    mostrarImagen(imagenActual - 1);
});

nextSlide.addEventListener('click', () => {
    mostrarImagen(imagenActual + 1);
});
```

El boton anterior resta 1.

El boton siguiente suma 1.

Si estas en la imagen 2:

```txt
Anterior: 2 - 1 = 1
Siguiente: 2 + 1 = 3
```

Si te sales del rango, la funcion `mostrarImagen` lo corrige usando `%`.

### 3.9. Cambio automatico

```js
setInterval(() => {
    mostrarImagen(imagenActual + 1);
}, 6000);
```

`setInterval` repite una funcion cada cierto tiempo.

`6000` significa 6000 milisegundos, o sea 6 segundos.

Cada 6 segundos se llama a `mostrarImagen(imagenActual + 1)`, por eso el slider avanza automaticamente.

## 4. Flexbox desde cero

Flexbox es un sistema de CSS para acomodar elementos en una direccion. Puede ser en fila o en columna.

Ejemplo en fila:

```txt
[1] [2] [3]
```

Ejemplo en columna:

```txt
[1]
[2]
[3]
```

Flexbox se usa mucho para headers, menus, botones, centrar elementos y separar contenido.

### 4.1. El contenedor manda

Este HTML tiene un padre y tres hijos:

```html
<div class="contenedor">
    <div class="caja">1</div>
    <div class="caja">2</div>
    <div class="caja">3</div>
</div>
```

Si pones Flexbox en el padre:

```css
.contenedor {
    display: flex;
}
```

Los hijos se acomodan en fila por defecto:

```txt
[1] [2] [3]
```

La regla mental es: el contenedor decide como se acomodan los hijos.

### 4.2. `flex-direction`

`flex-direction` decide la direccion principal.

```css
.contenedor {
    display: flex;
    flex-direction: row;
}
```

Resultado:

```txt
[1] [2] [3]
```

```css
.contenedor {
    display: flex;
    flex-direction: column;
}
```

Resultado:

```txt
[1]
[2]
[3]
```

En un menu responsive, normalmente usas fila en escritorio y columna en movil.

### 4.3. `justify-content`

`justify-content` alinea los elementos en el eje principal.

Si `flex-direction` es `row`, el eje principal es horizontal.

```css
justify-content: flex-start;
```

Los elementos van al inicio:

```txt
[1][2][3]
```

```css
justify-content: center;
```

Los elementos van al centro:

```txt
        [1][2][3]
```

```css
justify-content: space-between;
```

Los elementos se separan usando todo el espacio disponible:

```txt
[1]                 [2]                 [3]
```

En tu header se usa `space-between` porque quieres el logo a la izquierda y el menu a la derecha:

```txt
BBVA                                      MENU
```

### 4.4. `align-items`

`align-items` alinea los elementos en el eje secundario.

Si `flex-direction` es `row`, el eje secundario es vertical.

```css
align-items: center;
```

Eso centra verticalmente los elementos dentro del contenedor.

Sin `align-items: center`, pueden quedar pegados arriba. Con `align-items: center`, quedan centrados en altura.

### 4.5. `gap`

`gap` agrega espacio entre elementos.

```css
.contenedor {
    display: flex;
    gap: 20px;
}
```

Resultado:

```txt
[1]    [2]    [3]
```

Es mas limpio que poner margen a cada hijo, porque no tienes que preocuparte por quitar el margen del ultimo elemento.

### 4.6. `flex-wrap`

Por defecto, Flexbox intenta poner todo en una sola linea. Si no cabe, puede apretarse mucho.

Con `flex-wrap: wrap`, los elementos pueden bajar a otra linea.

```css
.contenedor {
    display: flex;
    flex-wrap: wrap;
}
```

Si hay espacio:

```txt
[Inicio] [Productos] [Servicios]
```

Si no hay espacio:

```txt
[Inicio] [Productos]
[Servicios]
```

### 4.7. Centrar algo con Flexbox

Este patron se usa muchisimo:

```css
.caja {
    display: flex;
    justify-content: center;
    align-items: center;
}
```

Con `flex-direction: row`, `justify-content` centra horizontalmente y `align-items` centra verticalmente.

Si cambias a `flex-direction: column`, los ejes se invierten: `justify-content` controla el eje vertical y `align-items` controla el horizontal.

## 5. Resumen mental

Menu hamburguesa:

```txt
HTML crea boton y nav.
CSS oculta el nav en movil.
JavaScript agrega o quita la clase activo.
CSS muestra el nav cuando tiene activo.
```

Slider:

```txt
HTML tiene una sola imagen.
JavaScript tiene una lista de imagenes.
JavaScript cambia el src de esa imagen.
CSS hace que se vea como banner.
```

Flexbox:

```txt
El padre tiene display: flex.
Los hijos se acomodan segun las reglas del padre.
Pueden ir en fila o en columna.
```

Frase importante para recordar:

El contenedor decide como se acomodan los hijos.
