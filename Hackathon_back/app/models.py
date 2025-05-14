from sqlmodel import SQLModel, Field

class Contacto(SQLModel, table=True):
    telefono: str = Field(primary_key=True)
    nombre: str
    hashed_password: str
