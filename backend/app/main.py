from __future__ import annotations
import hashlib, hmac, os, secrets, time
from datetime import date, datetime, timezone
from typing import Annotated, Literal
from fastapi import Depends, FastAPI, HTTPException, Query
from fastapi.middleware.cors import CORSMiddleware
from fastapi.security import HTTPAuthorizationCredentials, HTTPBearer
from pydantic import BaseModel, ConfigDict, EmailStr, Field
from sqlalchemy import Boolean, Date, DateTime, ForeignKey, Integer, String, Text, create_engine, func, select
from sqlalchemy.orm import DeclarativeBase, Mapped, Session, mapped_column, sessionmaker

DATABASE_URL=os.getenv("DATABASE_URL","postgresql+psycopg://acervovivo:CHANGE_ME@db:5432/acervovivo")
SECRET_KEY=os.getenv("APP_SECRET_KEY","")
if len(SECRET_KEY)<32: raise RuntimeError("APP_SECRET_KEY precisa ter pelo menos 32 caracteres.")
TOKEN_TTL=604800
engine=create_engine(DATABASE_URL,pool_pre_ping=True)
SessionLocal=sessionmaker(bind=engine,autoflush=False,expire_on_commit=False)

class Base(DeclarativeBase): pass
class User(Base):
    __tablename__="users"
    id:Mapped[int]=mapped_column(Integer,primary_key=True)
    name:Mapped[str]=mapped_column(String(140),nullable=False)
    email:Mapped[str]=mapped_column(String(254),unique=True,index=True,nullable=False)
    phone:Mapped[str|None]=mapped_column(String(40))
    registration_code:Mapped[str|None]=mapped_column(String(60),unique=True)
    password_hash:Mapped[str]=mapped_column(String(256),nullable=False)
    role:Mapped[str]=mapped_column(String(20),default="reader",nullable=False)
    active:Mapped[bool]=mapped_column(Boolean,default=True,nullable=False)
    created_at:Mapped[datetime]=mapped_column(DateTime(timezone=True),server_default=func.now(),nullable=False)
class Book(Base):
    __tablename__="books"
    id:Mapped[int]=mapped_column(Integer,primary_key=True)
    title:Mapped[str]=mapped_column(String(240),index=True,nullable=False)
    author:Mapped[str]=mapped_column(String(240),nullable=False)
    isbn:Mapped[str|None]=mapped_column(String(20),index=True)
    category:Mapped[str|None]=mapped_column(String(100),index=True)
    publication_year:Mapped[int|None]=mapped_column(Integer)
    total_copies:Mapped[int]=mapped_column(Integer,default=1,nullable=False)
    publisher:Mapped[str|None]=mapped_column(String(180))
    description:Mapped[str|None]=mapped_column(Text)
    created_at:Mapped[datetime]=mapped_column(DateTime(timezone=True),server_default=func.now(),nullable=False)
class Loan(Base):
    __tablename__="loans"
    id:Mapped[int]=mapped_column(Integer,primary_key=True)
    book_id:Mapped[int]=mapped_column(ForeignKey("books.id",ondelete="RESTRICT"),index=True,nullable=False)
    user_id:Mapped[int]=mapped_column(ForeignKey("users.id",ondelete="RESTRICT"),index=True,nullable=False)
    loan_date:Mapped[date]=mapped_column(Date,default=date.today,nullable=False)
    due_date:Mapped[date]=mapped_column(Date,nullable=False)
    returned_at:Mapped[date|None]=mapped_column(Date)
    created_at:Mapped[datetime]=mapped_column(DateTime(timezone=True),server_default=func.now(),nullable=False)

class UserCreate(BaseModel):
    name:str=Field(min_length=2,max_length=140)
    email:EmailStr
    password:str=Field(min_length=10,max_length=128)
    phone:str|None=None
    registration_code:str|None=None
    role:Literal["reader","librarian"]="reader"
class UserOut(BaseModel):
    model_config=ConfigDict(from_attributes=True)
    id:int; name:str; email:EmailStr; phone:str|None; registration_code:str|None; role:str; active:bool
class LoginIn(BaseModel):
    email:EmailStr; password:str
class BookCreate(BaseModel):
    title:str=Field(min_length=1,max_length=240)
    author:str=Field(min_length=1,max_length=240)
    isbn:str|None=None; category:str|None=None
    publication_year:int|None=Field(default=None,ge=0,le=2100)
    total_copies:int=Field(default=1,ge=0,le=100000)
    publisher:str|None=None; description:str|None=None
class BookOut(BaseModel):
    model_config=ConfigDict(from_attributes=True)
    id:int; title:str; author:str; isbn:str|None; category:str|None
    publication_year:int|None; total_copies:int; publisher:str|None; description:str|None
class BookAvailability(BookOut): available_copies:int
class LoanCreate(BaseModel):
    book_id:int; user_id:int; due_date:date
class LoanOut(BaseModel):
    id:int; book_id:int; user_id:int; loan_date:date; due_date:date
    returned_at:date|None; book_title:str; user_name:str

app=FastAPI(title="AcervoVivo API",version="1.0.0",description="API central do AcervoVivo.")
origins=[x.strip() for x in os.getenv("CORS_ORIGINS","*").split(",") if x.strip()]
app.add_middleware(CORSMiddleware,allow_origins=origins or ["*"],allow_credentials=False,allow_methods=["*"],allow_headers=["*"])
bearer=HTTPBearer(auto_error=False)
def get_db():
    with SessionLocal() as db: yield db
Db=Annotated[Session,Depends(get_db)]
def hash_password(password:str)->str:
    salt=secrets.token_bytes(16); digest=hashlib.pbkdf2_hmac("sha256",password.encode(),salt,310000)
    return "pbkdf2_sha256$310000$" + salt.hex() + "$" + digest.hex()
    try:
        scheme,rounds,salt,digest=encoded.split("$")
        if scheme!="pbkdf2_sha256": return False
        check=hashlib.pbkdf2_hmac("sha256",password.encode(),bytes.fromhex(salt),int(rounds)).hex()
        return hmac.compare_digest(check,digest)
    except (ValueError,TypeError): return False
def token_for(user:User)->str:
    exp=int(time.time())+TOKEN_TTL
    body=f"{user.id}:{user.role}:{exp}:{secrets.token_hex(8)}"
    sig=hmac.new(SECRET_KEY.encode(),body.encode(),hashlib.sha256).hexdigest()
    return f"{body}:{sig}"
def get_current(credentials:Annotated[HTTPAuthorizationCredentials|None,Depends(bearer)],db:Db)->User:
    if credentials is None: raise HTTPException(401,"Faça login para continuar.")
    try:
        uid,role,exp,nonce,sig=credentials.credentials.split(":")
        body=":".join((uid,role,exp,nonce))
        expected=hmac.new(SECRET_KEY.encode(),body.encode(),hashlib.sha256).hexdigest()
        if not hmac.compare_digest(sig,expected) or int(exp)<int(time.time()): raise ValueError
    except (ValueError,TypeError): raise HTTPException(401,"Sessão inválida ou expirada.")
    user=db.get(User,int(uid))
    if not user or not user.active or user.role!=role: raise HTTPException(401,"Conta inativa ou sessão inválida.")
    return user
Current=Annotated[User,Depends(get_current)]
def require_librarian(user:Current)->User:
    if user.role!="librarian": raise HTTPException(403,"Apenas bibliotecários podem realizar esta operação.")
    return user
Librarian=Annotated[User,Depends(require_librarian)]
def as_loan(db:Session,loan:Loan)->LoanOut:
    book=db.get(Book,loan.book_id); reader=db.get(User,loan.user_id)
    return LoanOut(id=loan.id,book_id=loan.book_id,user_id=loan.user_id,loan_date=loan.loan_date,due_date=loan.due_date,returned_at=loan.returned_at,book_title=book.title if book else "",user_name=reader.name if reader else "")

@app.on_event("startup")
def startup():
    Base.metadata.create_all(bind=engine)
    email=os.getenv("BOOTSTRAP_LIBRARIAN_EMAIL","").strip().lower()
    password=os.getenv("BOOTSTRAP_LIBRARIAN_PASSWORD","")
    if email and password and password!="CHANGE_ME_NOW":
        with SessionLocal() as db:
            if not db.scalar(select(User.id).where(User.email==email)):
                db.add(User(name=os.getenv("BOOTSTRAP_LIBRARIAN_NAME","Bibliotecário"),email=email,password_hash=hash_password(password),role="librarian",active=True)); db.commit()
@app.get("/health")
def health(): return {"status":"ok","service":"acervovivo-api"}
@app.post("/auth/login")
def login(data:LoginIn,db:Db):
    user=db.scalar(select(User).where(User.email==str(data.email).lower()))
    if not user or not user.active or not verify_password(data.password,user.password_hash): raise HTTPException(401,"E-mail ou senha incorretos.")
    return {"access_token":token_for(user),"token_type":"bearer","expires_in":TOKEN_TTL,"user":UserOut.model_validate(user)}
@app.get("/auth/me",response_model=UserOut)
def me(user:Current): return user

@app.get("/books",response_model=list[BookAvailability])
def books(db:Db,q:str|None=Query(default=None,max_length=120),category:str|None=None,limit:int=Query(default=100,ge=1,le=300),offset:int=Query(default=0,ge=0)):
    query=select(Book)
    if q:
        p=f"%{q.strip()}%"; query=query.where(Book.title.ilike(p)|Book.author.ilike(p)|Book.isbn.ilike(p))
    if category: query=query.where(Book.category.ilike(category.strip()))
    rows=db.scalars(query.order_by(Book.title).limit(limit).offset(offset)).all()
    out=[]
    for b in rows:
        count=db.scalar(select(func.count(Loan.id)).where(Loan.book_id==b.id,Loan.returned_at.is_(None))) or 0
        out.append(BookAvailability(**BookOut.model_validate(b).model_dump(),available_copies=max(0,b.total_copies-count)))
    return out
@app.get("/books/{book_id}",response_model=BookAvailability)
def book_detail(book_id:int,db:Db):
    b=db.get(Book,book_id)
    if not b: raise HTTPException(404,"Livro não encontrado.")
    count=db.scalar(select(func.count(Loan.id)).where(Loan.book_id==b.id,Loan.returned_at.is_(None))) or 0
    return BookAvailability(**BookOut.model_validate(b).model_dump(),available_copies=max(0,b.total_copies-count))
@app.post("/books",response_model=BookOut,status_code=201)
def create_book(data:BookCreate,db:Db,user:Librarian):
    b=Book(**data.model_dump()); db.add(b); db.commit(); db.refresh(b); return b
@app.put("/books/{book_id}",response_model=BookOut)
def update_book(book_id:int,data:BookCreate,db:Db,user:Librarian):
    b=db.get(Book,book_id)
    if not b: raise HTTPException(404,"Livro não encontrado.")
    for k,v in data.model_dump().items(): setattr(b,k,v)
    db.commit(); db.refresh(b); return b
@app.delete("/books/{book_id}",status_code=204)
def delete_book(book_id:int,db:Db,user:Librarian):
    b=db.get(Book,book_id)
    if not b: raise HTTPException(404,"Livro não encontrado.")
    if db.scalar(select(Loan.id).where(Loan.book_id==book_id,Loan.returned_at.is_(None)).limit(1)): raise HTTPException(409,"Livro possui empréstimo em aberto.")
    db.delete(b); db.commit()

@app.post("/users",response_model=UserOut,status_code=201)
def create_user(data:UserCreate,db:Db,user:Librarian):
    email=str(data.email).lower()
    if db.scalar(select(User.id).where(User.email==email)): raise HTTPException(409,"E-mail já cadastrado.")
    if data.registration_code and db.scalar(select(User.id).where(User.registration_code==data.registration_code)): raise HTTPException(409,"Matrícula/código já cadastrado.")
    u=User(name=data.name.strip(),email=email,phone=data.phone,registration_code=data.registration_code,password_hash=hash_password(data.password),role=data.role,active=True)
    db.add(u); db.commit(); db.refresh(u); return u
@app.get("/users",response_model=list[UserOut])
def users(db:Db,user:Librarian,q:str|None=None,limit:int=Query(default=100,ge=1,le=300),offset:int=Query(default=0,ge=0)):
    query=select(User)
    if q:
        p=f"%{q.strip()}%"; query=query.where(User.name.ilike(p)|User.email.ilike(p)|User.registration_code.ilike(p))
    return db.scalars(query.order_by(User.name).limit(limit).offset(offset)).all()

@app.post("/loans",response_model=LoanOut,status_code=201)
def create_loan(data:LoanCreate,db:Db,user:Librarian):
    if data.due_date<date.today(): raise HTTPException(422,"Data prevista deve ser hoje ou futura.")
    b=db.scalar(select(Book).where(Book.id==data.book_id).with_for_update()); reader=db.get(User,data.user_id)
    if not b: raise HTTPException(404,"Livro não encontrado.")
    if not reader or not reader.active or reader.role!="reader": raise HTTPException(404,"Leitor ativo não encontrado.")
    active=db.scalar(select(func.count(Loan.id)).where(Loan.book_id==b.id,Loan.returned_at.is_(None))) or 0
    if active>=b.total_copies: raise HTTPException(409,"Não há exemplares disponíveis.")
    loan=Loan(book_id=b.id,user_id=reader.id,loan_date=date.today(),due_date=data.due_date); db.add(loan); db.commit(); db.refresh(loan); return as_loan(db,loan)
@app.post("/loans/{loan_id}/return",response_model=LoanOut)
def return_loan(loan_id:int,db:Db,user:Librarian):
    loan=db.get(Loan,loan_id)
    if not loan: raise HTTPException(404,"Empréstimo não encontrado.")
    if loan.returned_at: raise HTTPException(409,"Empréstimo já devolvido.")
    loan.returned_at=date.today(); db.commit(); db.refresh(loan); return as_loan(db,loan)
@app.get("/loans",response_model=list[LoanOut])
def loans(db:Db,user:Current,open_only:bool=False,limit:int=Query(default=100,ge=1,le=300),offset:int=Query(default=0,ge=0)):
    query=select(Loan)
    if user.role!="librarian": query=query.where(Loan.user_id==user.id)
    if open_only: query=query.where(Loan.returned_at.is_(None))
    rows=db.scalars(query.order_by(Loan.loan_date.desc(),Loan.id.desc()).limit(limit).offset(offset)).all()
    return [as_loan(db,x) for x in rows]
