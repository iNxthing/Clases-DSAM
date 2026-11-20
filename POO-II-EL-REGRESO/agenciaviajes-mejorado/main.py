from fastapi import FastAPI
import models
from database import engine
from Routers import clientes, paquetes, reservas


models.Base.metadata.create_all(bind=engine)


app = FastAPI(title="Agencia De Viajes")

app.include_router(paquetes.router)
app.include_router(reservas.router)
app.include_router(clientes.router)
