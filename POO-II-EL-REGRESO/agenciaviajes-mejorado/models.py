from sqlalchemy import  ForeignKey, String
from sqlalchemy.orm import Mapped , mapped_column, relationship
from database import Base

class paquete(Base):
    __tablename__ = "paquetes"
    id: Mapped[int] = mapped_column(primary_key=True, index=True)
    destino: Mapped[str] = mapped_column(String(100), nullable=False)
    precio: Mapped[int] = mapped_column(nullable=False)
    capacidad_maxima: Mapped[int] = mapped_column(nullable=False)
    capacidad_disponible: Mapped[int] = mapped_column(nullable=False)
    reservas: Mapped[list["Reserva"]] = relationship(back_populates="paquete")

class Cliente(Base):
    __tablename__ = "clientes"
    id: Mapped[int] = mapped_column(primary_key=True,index=True)
    nombre: Mapped[str] = mapped_column(String(50),nullable=False)
    reservas: Mapped[list["Reserva"]] = relationship(back_populates="cliente")

class Reserva(Base):
    __tablename__ = "reservas"
    id: Mapped[int] = mapped_column(primary_key=True,index=True)

    numero_de_personas: Mapped[int] = mapped_column(nullable=False)
    cancelada: Mapped[bool] = mapped_column(default=False)

    cliente_id: Mapped[int] = mapped_column(ForeignKey("clientes.id"),nullable=False)
    paquete_id: Mapped[int] = mapped_column(ForeignKey("paquetes.id"), nullable=False)
    
    cliente: Mapped["Cliente"] = relationship(back_populates="reservas")
    paquete: Mapped["paquete"] = relationship(back_populates="reservas")

