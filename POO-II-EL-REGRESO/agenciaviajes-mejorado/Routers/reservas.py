from fastapi import APIRouter , Depends, HTTPException
from sqlalchemy.orm import Session
from database import get_db
import models
import schemas


router = APIRouter(prefix="/reservas", tags=["Reservas"])
depende = Depends(get_db)

@router.post("/",response_model=schemas.ReservaResponse,status_code=201)
def crear_reserva(datos: schemas.CrearReserva,db: Session = depende):
    cliente = db.query(models.Cliente).filter(models.Cliente.id == datos.cliente_id).first()
    if not cliente:
        raise HTTPException(status_code=404,detail="El cliente no existe")
    
    paquete = db.query(models.paquete).filter(models.paquete.id == datos.paquete_id).first()

    if not paquete:
        raise HTTPException(status_code=404,detail="El paquete no existe")

    if paquete.capacidad_disponible < datos.numero_de_personas:
        raise HTTPException(
                status_code=400,
        	detail=f"No hay suficientes cupos. Disponibles: {paquete.capacidad_disponible}"
        )

    paquete.capacidad_disponible -=datos.numero_de_personas

    nueva_reserva = models.Reserva(
        cliente_id = datos.cliente_id,
        paquete_id = datos.paquete_id,
        numero_de_personas = datos.numero_de_personas,
        cancelada = False
    )
    db.add(nueva_reserva)
    db.commit()
    db.refresh(nueva_reserva)
    return nueva_reserva


@router.get("/" ,response_model=list[schemas.ReservaResponse])
def listar_reservas(db: Session = depende):
    return db.query(models.Reserva).all()

