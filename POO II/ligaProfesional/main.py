from fastapi import FastAPI, HTTPException
from pydantic import BaseModel , Field

app = FastAPI(title ="Liga  pro API")

equipos = [
    {
        "id": 1,
        "nombre": "Robapollo FC",
        "ciudad": "Santa Marta"
    },
    {
        "id": 2,
        "nombre": "Equipo azul",
        "ciudad": "Soledad"
    }
]


class EquipoEntrada(BaseModel):
    nombre: str = Field(min_length =2, max_length = 50)
    ciudad: str = Field(min_length =2, max_length = 50)

@app.get("/")
def inicio():
    return {"mensaje": "Bienvenido a la liga pro"}

@app.get("/equipos", tags=["Equipos"])
def lsitar_equipos():
    return equipos


@app.get("/equipos/{id}", tags=["Equipos"])
def buscar_equipo(id: int):
    for equipo in equipos:
        if equipo["id"] == id:
            return equipo
    raise HTTPException(status_code=404, detail="Equipo no encontrado")

@app.post("/equipos", status_code=201, tags=["Equipos"])
def crear_equipo(equipo: EquipoEntrada):
    nuevo_id = len(equipos) + 1
    nuevo_equipo = {
        "id": nuevo_id,
        "nombre": equipo.nombre,
        "ciudad": equipo.ciudad
    }
    equipos.append(nuevo_equipo)
    return nuevo_equipo

@app.put("/equipos/{id}", tags=["Equipos"])
def actualizar_equipo(id: int, datos: EquipoEntrada):
    for equipo in equipos:
        if equipo["id"] == id:
            equipo["nombre"] = datos.nombre
            equipo["ciudad"] = datos.ciudad
            return equipo
    raise HTTPException(status_code=404, detail="Equipo no encontrado")

@app.delete("/equipos/{id}", tags=["Equipos"])
def eliminar_equipo(id: int):
    for equipo in equipos:
        if equipo["id"] == id:
            equipos.remove(equipo)
            return {"mensaje": "Equipo eliminado"}
    raise HTTPException(status_code=404, detail="Equipo no encontrado")


jugadores = []
partidos = []

class JugadorEntrada(BaseModel):
    nombre: str = Field(min_length=2, max_length=50)
    posicion: str = Field(min_length=2, max_length=50)
    edad: int = Field(ge=16, le=50)
    equipo_id: int     
    
@app.get("/jugadores", tags=["Jugadores"])
def listar_jugadores():
    return jugadores

@app.get("/jugadores/{id}", tags=["Jugadores"])
def buscar_jugador(id: int):
    for jugador in jugadores:
        if jugador["id"] == id:
            return jugador
    raise HTTPException(status_code=404, detail="Jugador no encontrado")

@app.post("/jugadores", status_code=201, tags=["Jugadores"])
def crear_jugador(jugador: JugadorEntrada):
    existe = any(
        equipo["id"] == jugador.equipo_id 
        for equipo in equipos
    )
    
    if not existe:
        raise HTTPException(status_code=404, detail="Equipo no existe")
    
    nuevo_id = len(jugadores) + 1
    nuevo_jugador = {
        "id": nuevo_id,
        "nombre": jugador.nombre,
        "posicion": jugador.posicion,
        "edad": jugador.edad,
        "equipo_id": jugador.equipo_id
    }
    jugadores.append(nuevo_jugador)
    return nuevo_jugador

class partidoEntrada(BaseModel):
    equipo_local_id: int
    equipo_visitante_id: int
    
class ResultadoEntrada(BaseModel):
    goles_local: int = Field(ge=0)
    goles_visitante: int = Field(ge=0)
    
@app.post("/partidos", status_code=201, tags=["Partidos"])
def crear_partido(partido: partidoEntrada):
    if partido.equipo_local_id == partido.equipo_visitante_id:
        raise HTTPException(status_code=400,detail="Un equipo no puede jugar contra si mismo")
    ids_equipos = {equipo["id"] for equipo in equipos}
    
    if partido.equipo_local_id not in ids_equipos:
        raise HTTPException(status_code=404,detail="Equipo local no encontrado")
    
    if partido.equipo_visitante_id_id not in ids_equipos:
            raise HTTPException(status_code=404,detail="Equipo visitante no encontrado")
        
    nuevo_id = len(partido) + 1
    
    nuevo_partido = {
        "id": nuevo_id,
        "equipo_local_id": partido.equipo_local_id,
        "equipo_visitante_id": partido.equipo_visitante_id,
        "goles_local": None,
        "goles_visitante": None,
        "estado" : "Programado"
    }
    partidos.append(nuevo_partido)



