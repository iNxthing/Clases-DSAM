# Guía Pedagógica: De Listas en Memoria a una API REST con Base de Datos Relacional

Bienvenido a esta guía. Si estás transitando el paso de manejar datos con listas en memoria a construir una API profesional conectada a una base de datos relacional con **FastAPI** y **SQLAlchemy**, este documento detalla los conceptos, las diferencias arquitectónicas y el flujo técnico fundamental que necesitas dominar.

---

## 1. Comparativa de Arquitectura: Proyecto Base vs. Proyecto Mejorado

### Proyecto Base (`agenciaviajes`)
En la versión inicial, todo el sistema residía en un único archivo (`main.py`) y los datos se almacenaban en variables globales:

* **Almacenamiento**: Listas de diccionarios en memoria RAM (`paquetes_turisticos = []`, `clientes = []`, `reservas = []`).
* **Ciclo de Vida de los Datos**: Volátil. Al apagar o reiniciar el servidor (`uvicorn`), toda la información creada desaparecía.
* **Integridad Referencial**: Manual. Para relacionar una reserva con un cliente o paquete, se iteraba con bucles `for` buscando IDs coincidentes.
* **Estructura del Proyecto**: Monolítica en un solo archivo. Lógica HTTP, modelos y persistencia mezclados.

### Proyecto Mejorado (`agenciaviajes-mejorado`)
En la versión evolucionada, el sistema adopta una arquitectura modular basada en separación de responsabilidades:

* **Almacenamiento**: Persistencia real en disco mediante un motor de base de datos relacional (**MySQL**).
* **Ciclo de Vida de los Datos**: Permanente. Los datos sobreviven a reinicios, caídas del servicio y despliegues.
* **Integridad Referencial**: Garantizada por el motor de base de datos mediante **Claves Foráneas (`ForeignKey`)**. Si un ID no existe, la base de datos rechaza la operación.
* **Estructura del Proyecto**:
  * `database.py`: Configuración del motor, pool de conexiones y sesión.
  * `models.py`: Entidades relacionales (tablas) mapeadas con el ORM de SQLAlchemy.
  * `schemas.py`: Contratos de datos (DTOs) validados con Pydantic para peticiones y respuestas.
  * `Routers/`: Módulos independientes por dominio (`paquetes.py`, `clientes.py`, `reservas.py`).
  * `main.py`: Punto de entrada que inicializa la aplicación y registra las rutas.

---

## 2. Cuadro Comparativo de Operaciones

| Aspecto | Con Listas en Memoria (`agenciaviajes`) | Con Base de Datos y ORM (`agenciaviajes-mejorado`) |
| :--- | :--- | :--- |
| **Consultar todos** | `return lista` | `db.query(models.Paquete).all()` |
| **Buscar por ID** | Bucle `for item in lista: if item["id"] == id` | `db.query(models.Paquete).filter(models.Paquete.id == id).first()` |
| **Insertar** | `lista.append(nuevo_diccionario)` | `db.add(nuevo_objeto)` seguido de `db.commit()` |
| **Eliminar** | `lista.remove(item)` | `db.delete(item)` seguido de `db.commit()` |
| **Actualizar** | Mutación directa del diccionario en el índice | Modificación de propiedades del objeto recuperado y `db.commit()` |
| **Generación de ID** | `len(lista) + 1` (propenso a duplicados al borrar) | `AUTO_INCREMENT` nativo y seguro de MySQL |

---

## 3. Cómo Funciona FastAPI con una Base de Datos Relacional

El flujo de trabajo se divide en capas coordinadas por FastAPI:

### A. La Sesión de Base de Datos y su Ciclo de Vida (`database.py`)
Conectar a una base de datos requiere recursos de red. Para optimizar, se crea un canal temporal llamado **Sesión** por cada petición:

```python
def get_db():
    db = SessionLocal()  # 1. Abre conexión
    try:
        yield db         # 2. La entrega a la ruta
    finally:
        db.close()       # 3. La cierra SIEMPRE al terminar la respuesta
```

### B. Inyección de Dependencias (`Depends`)
En las funciones de los routers se define el parámetro `db: Session = Depends(get_db)`. FastAPI ejecuta `get_db()`, suministra la sesión a la función y, una vez enviada la respuesta al cliente, ejecuta el bloque `finally` para liberar la conexión al pool.

### C. La Separación entre Schemas (Pydantic) y Models (SQLAlchemy)
* **`models.py` (SQLAlchemy)**: Representa la tabla física en la base de datos. Se utiliza para consultar y persistir datos.
* **`schemas.py` (Pydantic)**: Representa el JSON que viaja por la red.
  * **Schema de Entrada (`Crear...`)**: Valida tipos, rangos numéricos y longitudes de texto antes de tocar la base de datos.
  * **Schema de Salida (`...Response`)**: Filtra datos sensibles, añade el `id` autoincremental y serializa la salida con `from_attributes = True`.

### D. Atomicidad en Transacciones (ACID)
Al realizar una operación como una reserva:
1. Se consulta el paquete y se restan sus cupos disponibles.
2. Se instancia el nuevo registro de reserva.
3. Se invoca `db.commit()`.

Ambas modificaciones (la actualización de cupos y la creación de la reserva) se consolidan en una única transacción de MySQL. Si ocurre algún error en el proceso, ninguna de las dos modificaciones se almacena, evitando datos corruptos o desfasados.

---

## 4. Ejemplo Práctico: Adaptar el Patrón a Otro Proyecto (Sistema de Biblioteca)

Para evidenciar la reutilización de este diseño, observemos cómo se modela un sistema de préstamos de libros:

### A. Modelos de Base de Datos (`models.py`)
```python
from sqlalchemy import String, ForeignKey
from sqlalchemy.orm import Mapped, mapped_column, relationship
from database import Base

class Libro(Base):
    __tablename__ = "libros"

    id: Mapped[int] = mapped_column(primary_key=True, index=True)
    titulo: Mapped[str] = mapped_column(String(100), nullable=False)
    autor: Mapped[str] = mapped_column(String(50), nullable=False)
    ejemplares_disponibles: Mapped[int] = mapped_column(nullable=False)

    prestamos: Mapped[list["Prestamo"]] = relationship(back_populates="libro")


class Prestamo(Base):
    __tablename__ = "prestamos"

    id: Mapped[int] = mapped_column(primary_key=True, index=True)
    usuario_nombre: Mapped[str] = mapped_column(String(50), nullable=False)
    activo: Mapped[bool] = mapped_column(default=True)

    # Clave Foránea apuntando a la tabla 'libros'
    libro_id: Mapped[int] = mapped_column(ForeignKey("libros.id"), nullable=False)

    libro: Mapped["Libro"] = relationship(back_populates="prestamos")
```

### B. Esquemas de Validación (`schemas.py`)
```python
from pydantic import BaseModel, Field

class LibroCreate(BaseModel):
    titulo: str = Field(min_length=1, max_length=100)
    autor: str = Field(min_length=2, max_length=50)
    ejemplares_disponibles: int = Field(gt=0)

class LibroResponse(LibroCreate):
    id: int

    class Config:
        from_attributes = True

class PrestamoCreate(BaseModel):
    usuario_nombre: str = Field(min_length=2, max_length=50)
    libro_id: int = Field(gt=0)

class PrestamoResponse(PrestamoCreate):
    id: int
    activo: bool

    class Config:
        from_attributes = True
```

### C. Endpoint de Transacción (`Routers/prestamos.py`)
```python
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from database import get_db
import models
import schemas

router = APIRouter(prefix="/prestamos", tags=["Préstamos"])

@router.post("/", response_model=schemas.PrestamoResponse, status_code=status.HTTP_201_CREATED)
def registrar_prestamo(datos: schemas.PrestamoCreate, db: Session = Depends(get_db)):
    # 1. Validar existencia del recurso
    libro = db.query(models.Libro).filter(models.Libro.id == datos.libro_id).first()
    if not libro:
        raise HTTPException(status_code=404, detail="El libro especificado no existe")

    # 2. Validar regla de negocio
    if libro.ejemplares_disponibles <= 0:
        raise HTTPException(status_code=400, detail="No quedan ejemplares disponibles para préstamo")

    # 3. Modificar stock
    libro.ejemplares_disponibles -= 1

    # 4. Crear registro dependiente
    nuevo_prestamo = models.Prestamo(
        usuario_nombre=datos.usuario_nombre,
        libro_id=datos.libro_id,
        activo=True
    )

    db.add(nuevo_prestamo)
    db.commit()              # Ambas operaciones se aplican de manera atómica
    db.refresh(nuevo_prestamo)
    return nuevo_prestamo
```

---

## 5. Reglas de Oro y Lecciones Aprendidas

1. **`create_all()` no altera tablas existentes**: Si modificas el nombre de una columna en `models.py`, `create_all()` no modificará la tabla en MySQL si esta ya fue creada previamente. Debes eliminar la tabla en desarrollo o utilizar herramientas de migración (**Alembic**).
2. **Sintaxis de Claves Foráneas**: En `ForeignKey("tabla.columna")` se debe referenciar el nombre exacto de la tabla (usualmente en plural) seguido de un punto y el nombre de la columna.
3. **Tipado moderno en SQLAlchemy 2.0**: Usa siempre `Mapped[tipo] = mapped_column(...)` para asegurar compatibilidad total con analizadores estáticos de tipos (Pylance/Pyright) y evitar advertencias sobre asignaciones a objetos `Column`.
4. **Respeto a los códigos de estado HTTP**:
   * `200 OK`: Consultas y actualizaciones exitosas con contenido.
   * `201 CREATED`: Creación exitosa de recursos.
   * `204 NO CONTENT`: Eliminación exitosa sin cuerpo de retorno.
   * `400 BAD REQUEST`: Errores de reglas de negocio (sin cupos, saldo insuficiente).
   * `404 NOT FOUND`: Recurso no encontrado por ID.
   * `422 UNPROCESSABLE ENTITY`: Errores automáticos de formato y validación disparados por Pydantic.
