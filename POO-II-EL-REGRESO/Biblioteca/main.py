from fastapi import FastAPI,HTTPException
from pydantic import BaseModel, Field


app = FastAPI(title="Api Biblioteca")


Libros = [
    {
        "id": 1,
        "titulo": "El señor de los anillos",
        "autor": "J.R.R. Tolkien",
        "año_publicacion": 1954,
        "ejemplares_totales": 5,
        "ejemplares_disponibles": 3
    },
    {
        "id": 2,
        "titulo": "Cien años de soledad",
        "autor": "Gabriel García Márquez",
        "año_publicacion": 1967,
        "ejemplares_totales": 4,
        "ejemplares_disponibles": 2
    },
    {
        "id": 3,
        "titulo": "1984",
        "autor": "George Orwell",
        "año_publicacion": 1949,
        "ejemplares_totales": 6,
        "ejemplares_disponibles": 4
    }
]


class Libro(BaseModel):
    titulo: str = Field(min_length=1, max_length=100)
    autor: str = Field(min_length=1, max_length=100)
    año_publicacion: int = Field(ge=1900, le=2026)
    ejemplares_totales: int = Field(ge=1)
    ejemplares_disponibles: int = Field(ge=0)

@app.get("/",tags=["Inicio"])
def home():
    return {"message": "Bienvenido a la API de la Biblioteca"}

@app.get("/health",tags=["Inicio"])
def health_check():
    return {"status": "OK"}




@app.get("/libros",tags=["Libros"])
def obtener_libros():
    return Libros

@app.get("/libros/{libro_id}",tags=["Libros"])
def obtener_libro(libro_id: int):
    for libro in Libros:
        if libro["id"] == libro_id:
            return libro
    raise HTTPException(status_code=404, detail="Libro no encontrado")


@app.post("/libros",tags=["Libros"])
def agregar_libro(libro: Libro):

    nuevo_id = len(Libros) + 1

    nuevo_libro = {
        "id": nuevo_id,
        "titulo": libro.titulo,
        "autor": libro.autor,
        "año_publicacion": libro.año_publicacion,
        "ejemplares_totales": libro.ejemplares_totales,
        "ejemplares_disponibles": libro.ejemplares_disponibles
    }
    Libros.append(nuevo_libro)
    return nuevo_libro

@app.put("/libros/{libro_id}",tags=["Libros"])
def actualizar_libro(libro_id: int, libro_actualizado: Libro):
    for libro in Libros:
        if libro["id"] == libro_id:
            libro["titulo"] = libro_actualizado.titulo
            libro["autor"] = libro_actualizado.autor
            libro["año_publicacion"] = libro_actualizado.año_publicacion
            libro["ejemplares_totales"] = libro_actualizado.ejemplares_totales
            libro["ejemplares_disponibles"] = libro_actualizado.ejemplares_disponibles
            return libro
    raise HTTPException(status_code=404, detail="Libro no encontrado")

@app.delete("/libros/{libro_id}",tags=["Libros"])
def eliminar_libro(libro_id: int):
    for libro in Libros:
        if libro["id"] == libro_id:
            Libros.remove(libro)
            return {"message": "Libro eliminado correctamente"}
    raise HTTPException(status_code=404, detail="Libro no encontrado")

socios = [
    {
        "id": 1,
        "nombre": "Soul",
        "email": "soulgamer@gmail.com",
    },
    {
        "id": 2,
        "nombre": "Nothing",
        "email": "nothing@gmail.com",
    },
    {
        "id": 3,
        "nombre": "EpicZimbaWe",
        "email": "EpicZimbaWe@gmail.com",
    }
]

class Socio(BaseModel):
    nombre: str = Field(min_length=1, max_length=100)
    email: str = Field(min_length=1, max_length=100)

@app.get("/socios",tags=["Socios"])
def obtener_socios():
    return socios

@app.get("/socios/{socio_id}",tags=["Socios"])
def obtener_socio(socio_id: int):
    for socio in socios:
        if socio["id"] == socio_id:
            return socio
    raise HTTPException(status_code=404, detail="Socio no encontrado")

@app.post("/socios",tags=["Socios"])
def agregar_socio(socio: Socio):
    nuevo_id = len(socios) + 1

    nuevo_socio = {
        "id": nuevo_id,
        "nombre": socio.nombre,
        "email": socio.email
    }
    socios.append(nuevo_socio)
    return nuevo_socio

@app.put("/socios/{socio_id}",tags=["Socios"])
def actualizar_socio(socio_id: int, socio_actualizado: Socio):
    for socio in socios:
        if socio["id"] == socio_id:
            socio["nombre"] = socio_actualizado.nombre
            socio["email"] = socio_actualizado.email
            return socio
    raise HTTPException(status_code=404, detail="Socio no encontrado")

@app.delete("/socios/{socio_id}",tags=["Socios"])
def eliminar_socio(socio_id: int):
    for socio in socios:
        if socio["id"] == socio_id:
            socios.remove(socio)
            return {"message": "Socio eliminado correctamente"}
    raise HTTPException(status_code=404, detail="Socio no encontrado")

prestamos = []

class Prestamo(BaseModel):
    libro_id: int = Field(ge=1)
    socio_id: int = Field(ge=1)
    esta_prestado: bool = True

@app.get("/prestamos",tags=["Prestamos"])
def obtener_prestamos():
    return prestamos

@app.post("/prestamos",tags=["Prestamos"])
def realizar_prestamo(prestamo: Prestamo):

    libro = any (libro["id"] == prestamo.libro_id for libro in Libros)

    socio = any (socio["id"] == prestamo.socio_id for socio in socios) 

    if not libro:
        raise HTTPException(status_code=404, detail="Libro no encontrado")
    if not socio:
        raise HTTPException(status_code=404, detail="Socio no encontrado")
    nuevo_id = len(prestamos) + 1
    nuevo_prestamo = {
        "id": nuevo_id,
        "libro_id": prestamo.libro_id,
        "socio_id": prestamo.socio_id,
        "esta_prestado": prestamo.esta_prestado
    }

    for libro in Libros:
        if libro["id"] == prestamo.libro_id:
            if libro["ejemplares_disponibles"] > 0:
                libro["ejemplares_disponibles"] -= 1
            else:
                raise HTTPException(status_code=400, detail="No hay ejemplares disponibles para este libro")

    prestamos.append(nuevo_prestamo)
    return nuevo_prestamo

@app.get("/prestamos/{socio_id}",tags=["Prestamos"])
def obtener_prestamos_por_socio(socio_id: int):
    socio_existe = any(socio["id"] == socio_id for socio in socios)
    if not socio_existe:
        raise HTTPException(status_code=404, detail="Socio no encontrado")

    prestamos_socio = []
    for prestamo in prestamos:
        if prestamo["socio_id"] == socio_id:
            prestamos_socio.append(prestamo)

    return prestamos_socio



@app.put("/prestamos/{prestamo_id}",tags=["Prestamos"])
def cancelar_prestamo(prestamo_id: int):
    cancelar = False
    existe = any(prestamo["id"] == prestamo_id for prestamo in prestamos)
    if not existe:
        raise HTTPException(status_code=404, detail="Prestamo no encontrado")

    for prestamo in prestamos:
        if prestamo["id"] == prestamo_id:
            prestamo["esta_prestado"] = cancelar
            for libro in Libros:
                if libro["id"] == prestamo["libro_id"]:
                    libro["ejemplares_disponibles"] += 1
    return {"message": "Prestamo cancelado correctamente"}
