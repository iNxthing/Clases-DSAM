from fastapi import APIRouter , Depends, HTTPException
from sqlalchemy.orm import Session
from database import get_db
import models
import schemas


router = APIRouter(prefix="/clientes", tags=["Clientes"])
depende = Depends(get_db)


@router.post("/",response_model=schemas.ClienteResponse,status_code=201)
def crear_cliente(cliente: schemas.CrearCliente,db: Session = depende):
    nuevo_cliente = models.Cliente(
        nombre = cliente.nombre
    )
    db.add(nuevo_cliente)
    db.commit()
    db.refresh(nuevo_cliente)
    return nuevo_cliente

@router.get("/",response_model=list[schemas.ClienteResponse],status_code=200)
def listar_clientes(db: Session = depende):
    return db.query(models.Cliente).all()

@router.get("/{id}",response_model=schemas.ClienteResponse)
def obtener_cliente(id: int,db: Session = depende):
    cliente = db.query(models.Cliente).filter(models.Cliente.id == id).first()
    if not cliente:
        raise HTTPException(status_code=404,detail="Cliente no encontrado")

    return cliente
