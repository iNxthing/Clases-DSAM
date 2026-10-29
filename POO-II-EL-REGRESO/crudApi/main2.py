from fastapi import FastAPI,HTTPException
from pydantic import BaseModel

app = FastAPI()


misiones = [
    {
        "id": 1,
        "nombre": "explorar marte",
        "destino": "marte",
        "tripulantes": 1
    },
    {
        "id": 2,
        "nombre": "explorar saturno",
        "destino": "saturno",
        "tripulantes": 2
    },
    {
        "id": 3,
        "nombre": "explorar la luna",
        "destino": "luna",
        "tripulantes": 4
    }
]

class Mision(BaseModel):
    nombre: str
    destino: str
    tripulantes: int

@app.get("/")
def inicio():
    return {"mensaje": "centro de control espacial,bienvenido"}

@app.get("/misiones")
def mostrar_misiones():
    return {"misiones" : misiones}

@app.get("/buscar")
def buscar_misiones(destino: str):
    resultados = []
    for mision in misiones:
        if mision["destino"].lower() == destino.lower():
            resultados.append(mision)
            
    return {"resultados": resultados}


@app.post("/misiones")
def agregar_mision(mision: Mision):
    nuevo_id = len(misiones) + 1
    nueva_mision = {
        "id": nuevo_id,
        "nombre": mision.nombre,
        "destino": mision.destino,
        "tripulantes": mision.tripulantes
    }
    misiones.append(nueva_mision)
    return {"mensaje": "Misión agregada exitosamente", "mision": nueva_mision}