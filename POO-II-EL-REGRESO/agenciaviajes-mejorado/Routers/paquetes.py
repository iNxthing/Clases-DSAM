from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from database import get_db
import models
import schemas

depende = Depends(get_db)
router = APIRouter(prefix="/paquetes",tags=["Paquetes"])

def existe(id: int, db:Session):
    return db.query(models.paquete).filter(models.paquete.id == id).first()



@router.post("/",response_model=schemas.PaqueteResponse,status_code=status.HTTP_201_CREATED)
def crear_paquete(paquete: schemas.CrearPaquete,db: Session= depende):
    nuevo_paquete = models.paquete(
        destino=paquete.destino,
        precio=paquete.precio,
        capacidad_maxima=paquete.capacidad_maxima,
        capacidad_disponible=paquete.capacidad_disponible
    )
    db.add(nuevo_paquete)
    db.commit()
    db.refresh(nuevo_paquete)
    return nuevo_paquete

@router.get("/",response_model=list[schemas.PaqueteResponse])
def listar_paquetes(db: Session = depende):
    return db.query(models.paquete).all()

@router.get("/{id}",response_model=schemas.PaqueteResponse)
def obtener_paquete(id: int,db: Session = depende):
    paquete = existe(id , db)

    if not paquete:
        raise HTTPException(status_code=404,detail="Paquete no encontrado")
    return paquete

@router.delete("/", status_code=204)
def eliminar_paquete(id: int , db: Session = depende):
    paquete = existe(id, db)

    if not paquete:
        raise HTTPException(status_code=404,detail="Paquete no encontrado")
    
    db.delete(paquete)
    db.commit()


@router.put("/{id}",response_model=schemas.PaqueteResponse)
def actualizar_paquete(id: int,paquete_actualizado: schemas.CrearPaquete,db: Session = depende):
    paquete = existe(id, db)
    if not paquete:
        raise HTTPException(status_code=404,detail="Paquete no encontrado")

    paquete.destino = paquete_actualizado.destino
    paquete.precio = paquete_actualizado.precio
    paquete.capacidad_maxima = paquete_actualizado.capacidad_maxima
    paquete.capacidad_disponible = paquete_actualizado.capacidad_disponible

