from sqlmodel import Session
from .models import Contacto
from .database import engine

def crear_contacto(contacto: Contacto):
    with Session(engine) as session:
        session.add(contacto)
        session.commit()
        return contacto