from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

incidentes = [
    {
        "id": 1,
        "ubicacion": "Timayui",
        "tipo": "Alcantarilla tapada",
        "afectados": 4,
        "prioridad": "alta"
    },
    {
        "id": 2,
        "ubicacion": "Calle 10",
        "tipo": "Fuga de gas",
        "afectados": 2,
        "prioridad": "media"
    },
    {
        "id": 3,
        "ubicacion": "Calle 20",
        "tipo": "Inundación",
        "afectados": 10,
        "prioridad": "alta"
    }
]


class Incidente(BaseModel):
    id: int
    ubicacion: str
    tipo: str
    afectados: int
    prioridad: str

@app.get("/")
def inicio():
    return {"mensaje": "Bienvenido al sistema de gestión de incidentes"}

@app.get("/mostrar_incidentes")
def mostrar_incidentes():
    return {"incidentes": incidentes}

@app.get("/incidentes")
def buscar_incidentes(id: int):
    resultados = []
    for incidente in incidentes:
        if incidente["id"] == id:
            resultados.append(incidente)
    return {"resultados": resultados}

@app.get("/incidentes/por-prioridad")
def buscar_por_prioridad(prioridad: str):
    resultados = []
    for incidente in incidentes:
        if incidente["prioridad"].lower() == prioridad.lower():
            resultados.append(incidente)
    return {"resultados": resultados}

@app.post("/incidentes")
def agregar_incidente(incidente: Incidente):
    nuevo_id = len(incidentes) + 1
    nuevo_incidente = {
        "id": nuevo_id,
        "ubicacion": incidente.ubicacion,
        "tipo": incidente.tipo,
        "afectados": incidente.afectados,
        "prioridad": incidente.prioridad
    }
    incidentes.append(nuevo_incidente)
    return {"mensaje": "Incidente agregado exitosamente", "incidente": nuevo_incidente}

@app.put("/incidentes")
def actualizar_incidente(id: int, incidente: Incidente):
    for i in range(len(incidentes)):
        if incidentes[i]["id"] == id:
            incidentes[i] = {
                "id": id,
                "ubicacion": incidente.ubicacion,
                "tipo": incidente.tipo,
                "afectados": incidente.afectados,
                "prioridad": incidente.prioridad
            }
            return {
                "mensaje": "Incidente actualizado exitosamente",
                "incidente": incidentes[i]
            }

    return {"mensaje": "Incidente no encontrado"}

@app.delete("/incidentes")
def eliminar_incidente(id: int):
    for i in range(len(incidentes)):
        if incidentes[i]["id"] == id:
            incidentes.pop(i)
            return {"mensaje": "Incidente eliminado exitosamente"}
    return {"mensaje": "Incidente no encontrado"}