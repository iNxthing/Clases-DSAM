from urllib.parse import quote_plus
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, declarative_base

USUARIO = ""
CLAVE = quote_plus("")      # quote_plus protege caracteres especiales
SERVIDOR = ""
PUERTO = 3306
BASE_DE_DATOS = "AgenciaViajesDB"

DATABASE_URL = f"mysql+pymysql://{USUARIO}:{CLAVE}@{SERVIDOR}:{PUERTO}/{BASE_DE_DATOS}"

engine = create_engine(DATABASE_URL, pool_pre_ping=True)
SessionLocal = sessionmaker(bind=engine, autoflush=False)
Base = declarative_base()


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
