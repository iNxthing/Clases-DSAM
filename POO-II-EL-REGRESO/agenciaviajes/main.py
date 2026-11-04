from logging import raiseExceptions

from fastapi import FastAPI,HTTPException
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



clientes = [
    {
        "id": 1,
        "nombre": "Nothing"
    },
    {
        "id": 2,
        "nombre": "EpicZimbawe"
    },
    {
        "id": 3,
        "nombre": "Nautilios"
    }
]

class cliente(BaseModel):
    nombre: str = Field(min_length=2,max_length=50)


@app.get("/clientes", tags=["Clientes"])
def mostrar_clentes():
    return clientes

@app.get("/clientes/{id}",tags=["Clientes"])
def filtrar_clientes(id: int):
    existe = any(
        cliente["id"] == id
        for cliente in clientes
    )

    if not existe:
        raise HTTPException(status_code=404,detail="El cliente no existe")
    
    for cliente in clientes:
        if cliente["id"] == id:
            return cliente



reservas = [

]

class reserva(BaseModel):
    cliente_id: int = Field(gt=0)
    numero_de_personas: int =Field(gt=0) 
    paquete_id: int = Field(gt=0)

@app.get("/reservas", tags=["Reservas"])
def mostrar_reservas():
    return reservas


@app.post("/reservas", tags=["Reservas"])
def agregar_reserva(datos: reserva):
    nuevo_id = len(reservas) + 1
    
    

    for paquete in paquetes_turisticos:
        if paquete["id"] == datos.paquete_id:
            capacidad = paquete["capacidad_maxima"]
            if datos.numero_de_personas > capacidad:
                raise HTTPException(status_code=400,detail="No se pudo completar la reserva porque la cantidad de personas seleccionadas exeden el limite de capacidad del paquete")

    paquete_existe = any(
        paquete["id"] == datos.paquete_id
        for paquete in paquetes_turisticos
    )
    
     


    if not paquete_existe:
        raise HTTPException(status_code=404,detail="Paquete no existe")
    else:

        nueva_reserva = {
            "id": nuevo_id,
            "cliente_id": datos.cliente_id,
            "numero_de_personas": datos.numero_de_personas,
            "paquete": datos.paquete_id,
            "cancelada": False
        }

        for paquete in paquetes_turisticos:
            if paquete["id"] == datos.paquete_id:
                if paquete["cupos_disponibles"] <= 0:
                    raise HTTPException(status_code=406,detail="Este paquete no tiene cupos disponibles")
                else:
                    cupos = paquete["cupos_disponibles"]
                    cupos_ocupados = cupos - datos.numero_de_personas
                
                    paquete["cupos_disponibles"] = cupos_ocupados
        
        
        reservas.append(nueva_reserva)
    raise HTTPException(status_code=201,detail="Reserva creada")


@app.put("/reservas",tags=["Reservas"])
def Cancelar_reserva(id: int,cancelar: bool):

    esta_cancelada = any(
        reserva["cancelada"] == True
        for reserva in reservas
    )

    if esta_cancelada:
        raise HTTPException(status_code=400,detail="No puedes cancelar una reserva ya cancelada")

    for reserva in reservas:
        if reserva["id"] == id:
            reserva["cancelada"] = cancelar
            for paquete in paquetes_turisticos:
                paquete["cupos_disponibles"] += reserva["numero_de_personas"]
                
    
    raise HTTPException(status_code=202,detail="Reserva cancelada con exito")



