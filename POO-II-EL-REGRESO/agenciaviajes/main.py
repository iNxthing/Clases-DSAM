from operator import gt

from fastapi import FastAPI,HTTPException, status
from pydantic import BaseModel,Field

app = FastAPI(title="Agencia de Viajes ")

paquetes_turisticos = [
    {
        "id": 1,
        "destino": "Santa Marta",
        "precio": 35000,
        "capacidad_maxima": 30,
        "cupos_disponibles": 30
    },
    {
        "id": 2,
        "destino": "Bucaramanga",
        "precio": 25000,
        "capacidad_maxima": 25,
        "cupos_disponibles": 25
    },
    {
        "id": 3,
        "destino": "Barranquilla",
        "precio": 43000,
        "capacidad_maxima": 40,
        "cupos_disponibles": 40
    }
    
]

class paquete_turistico(BaseModel):
    destino: str = Field(max_length=50)
    precio: int = Field(gt=0,le=50000)
    capacidad: int = Field(gt=0,le=50)
    cupos: int = Field(gt=0,le=50)


@app.get("/")
def home():
    raise HTTPException(status_code=200,detail="Bienvenido a la Agencia de Viajes")

@app.get("/paquetes", tags=["Paquetes"])
def paquetes():
    return paquetes_turisticos

@app.get("/paquetes/{id}", tags=["Paquetes"])
def paquetes_por_id(id: int):
    for paquete in paquetes_turisticos:
        if paquete["id"] == id:
            return paquete
    raise HTTPException(status_code=404,detail="El paquete no existe")

@app.post("/paquetes", tags=["Paquetes"])
def agregar_paquete(datos: paquete_turistico):
    nuevo_id= len(paquetes_turisticos) + 1

    nuevo_paquete_t = {
        "id": nuevo_id,
        "destino": datos.destino,
        "precio": datos.precio,
        "capacidad_maxima": datos.capacidad,
        "cupos_disponibles": datos.cupos

    }
    paquetes_turisticos.append(nuevo_paquete_t)
    raise HTTPException(status_code=201,detail=f"Paquete creado con exito")







reservas = [

]

class reserva(BaseModel):
    numero_personas: int =Field(gt=0) 
    paquete_id: int = Field(gt=0)
    cancelada: bool = False


@app.get("/reservas", tags=["Reservas"])
def mostrar_reservas():
    return reservas


@app.post("/reservas", tags=["Reservas"])
def agregar_reserva(datos: reserva):
    nuevo_id = len(reservas) + 1
    
    

    for paquete in paquetes_turisticos:
        if paquete["id"] == datos.paquete_id:
            capacidad = paquete["capacidad_maxima"]
            if datos.numero_personas > capacidad:
                raise HTTPException(status_code=400,detail="El paquete seleccionado no admite esa cantidad de personas")

    paquete_existe = any(
        paquete["id"] == datos.paquete_id
        for paquete in paquetes_turisticos
    )
    
    if not paquete_existe:
        raise HTTPException(status_code=404,detail="Paquete no existe")

    nueva_reserva = {
        "id": nuevo_id,
        "numero_de_personas": datos.numero_personas,
        "paquete": datos.paquete_id,
        "estado": datos.cancelada
    }
    reservas.append(nueva_reserva)
    raise HTTPException(status_code=201,detail="Reserva creada")

