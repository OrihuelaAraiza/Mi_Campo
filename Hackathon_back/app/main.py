from fastapi import FastAPI, HTTPException, Depends
from pydantic import BaseModel
from langchain_cohere import ChatCohere
from langchain_core.messages import SystemMessage, HumanMessage
from dotenv import load_dotenv
import os
from .database import init_db, engine
from .models import Contacto
from .crud import crear_contacto
from sqlmodel import Session, select
from .utils import hash_password
from .utils import verify_password

class ContactoCreate(BaseModel):
    telefono: str
    nombre: str
    password: str

class LoginRequest(BaseModel):
    telefono: str
    password: str
app = FastAPI()

# Modelo del input que recibirá la API
class PromptRequest(BaseModel):
    prompt: str

llm = ChatCohere(
    model="command-r-plus",
    cohere_api_key=("vIk5dLoLnHkRfYaS8IqNuDEc6DnY2B4Jh63SbrBe")
)

SYSTEM_PROMPT = """
Eres un chatbot que explica en terminos muy sencillos conceptos para que los agricultores entiendan conceptos básicos
de agricultura necesito que uses lenguaje muy sencillo en el cual expliques lo complicado con palabras MUY sencillas
y muy resumido, asi como posibles soluciones a sus problemas con el cultivo y como pueden arreglarlo.
UNICAMENTE PUEDES RESPONDER COSAS QUE SEAN DE AGRICULTURA Y MAXIMO 40 PALABRAS, si te preguntan de tierra centrate en 
que logren distinguir lo que te estan preguntando
"""

@app.post("/responder")
def responder_pregunta(request: PromptRequest):
    try:
        messages = [
            SystemMessage(content=SYSTEM_PROMPT),
            HumanMessage(content=request.prompt)
        ]
        respuesta = llm.invoke(messages)
        return {"respuesta": respuesta.content}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.on_event("startup")
def startup():
    init_db()

@app.post("/login/")
def login(request: LoginRequest):
    with Session(engine) as session:
        contacto = session.get(Contacto, request.telefono)
        if not contacto or not verify_password(request.password, contacto.hashed_password):
            raise HTTPException(status_code=401, detail="Credenciales inválidas")
        return {"mensaje": "Inicio de sesión exitoso"}

@app.post("/contactos/")
def registrar_usuario(contacto: ContactoCreate):
    with Session(engine) as session:
        existing_contacto = session.get(Contacto, contacto.telefono)
        if existing_contacto:
            raise HTTPException(status_code=400, detail="El usuario ya existe")
        hashed_pw = hash_password(contacto.password)
        nuevo_contacto = Contacto(
            telefono=contacto.telefono,
            nombre=contacto.nombre,
            hashed_password=hashed_pw
        )
        session.add(nuevo_contacto)
        session.commit()
        return {"mensaje": "Usuario registrado exitosamente"}

@app.get("/contactos/")
def obtener_contactos():
    with Session(engine) as session:
        contactos = session.exec(select(Contacto)).all()
        return contactos

@app.delete("/contactos/{telefono}")
def eliminar_contacto(telefono: str):
    with Session(engine) as session:
        contacto = session.get(Contacto, telefono)
        if not contacto:
            raise HTTPException(status_code=404, detail="Usuario no encontrado")
        session.delete(contacto)
        session.commit()
        return {"mensaje": "Contacto eliminado exitosamente"}