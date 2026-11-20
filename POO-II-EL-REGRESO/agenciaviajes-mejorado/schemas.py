from pydantic import BaseModel, Field

class CrearPaquete(BaseModel):
    destino: str = Field(min_length=1,max_length=100)
    precio: int = Field(gt=0)
    capacidad_maxima: int = Field(gt=0)
    capacidad_disponible: int = Field(gt=0)

class PaqueteResponse(CrearPaquete):
    id: int

    class Config:
        from_attributes = True

class CrearReserva(BaseModel):
    cliente_id: int = Field(gt=0)
    paquete_id: int = Field(gt=0)
    numero_de_personas: int = Field(gt=0)

class ReservaResponse(CrearReserva):
    id: int
    cancelada: bool

    class Config:
        from_attributes = True

class CrearCliente(BaseModel):
    nombre: str = Field(min_length=2, max_length=50)


class ClienteResponse(CrearCliente):
    id: int

    class Config:
        from_attributes = True
