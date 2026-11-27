import os
import uuid
from datetime import date, timedelta
import pytest
from fastapi.testclient import TestClient
from app.main import app

@pytest.fixture(scope="module")
def client():
    with TestClient(app) as test_client:
        yield test_client

ADMIN_EMAIL = os.environ["BOOTSTRAP_LIBRARIAN_EMAIL"]
ADMIN_PASSWORD = os.environ["BOOTSTRAP_LIBRARIAN_PASSWORD"]

def token_for(client, email, password):
    response = client.post("/auth/login", json={"email": email, "password": password})
    assert response.status_code == 200, response.text
    return response.json()["access_token"]

def test_health(client):
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json()["status"] == "ok"

def test_librarian_can_create_book_reader_and_process_loan(client):
    admin_token = token_for(client, ADMIN_EMAIL, ADMIN_PASSWORD)
    admin = {"Authorization": f"Bearer {admin_token}"}
    suffix = uuid.uuid4().hex[:10]
    book_response = client.post("/books", headers=admin, json={
        "title": "Test book " + suffix, "author": "Test author",
        "isbn": None, "category": "Teste", "publication_year": 2024,
        "total_copies": 1, "publisher": "Teste", "description": "Livro para teste automatizado"
    })
    assert book_response.status_code == 201, book_response.text
    book_id = book_response.json()["id"]

    reader_email = f"reader-{suffix}@example.com"
    reader_password = "Test-password-123"
    reader_response = client.post("/users", headers=admin, json={
        "name": "Leitor de teste", "email": reader_email, "password": reader_password,
        "registration_code": "TEST-" + suffix, "role": "reader"
    })
    assert reader_response.status_code == 201, reader_response.text
    reader_id = reader_response.json()["id"]

    loan_response = client.post("/loans", headers=admin, json={
        "book_id": book_id, "user_id": reader_id,
        "due_date": (date.today() + timedelta(days=14)).isoformat()
    })
    assert loan_response.status_code == 201, loan_response.text
    loan_id = loan_response.json()["id"]

    available = client.get("/books")
    assert available.status_code == 200
    book = next(x for x in available.json() if x["id"] == book_id)
    assert book["available_copies"] == 0

    reader_token = token_for(client, reader_email, reader_password)
    reader_loans = client.get("/loans", headers={"Authorization": f"Bearer {reader_token}"})
    assert reader_loans.status_code == 200
    assert any(x["id"] == loan_id for x in reader_loans.json())

    returned = client.post(f"/loans/{loan_id}/return", headers=admin)
    assert returned.status_code == 200, returned.text
    assert returned.json()["returned_at"] is not None

    available_after = client.get("/books").json()
    book_after = next(x for x in available_after if x["id"] == book_id)
    assert book_after["available_copies"] == 1

def test_reader_cannot_create_book(client):
    admin_token = token_for(client, ADMIN_EMAIL, ADMIN_PASSWORD)
    suffix = uuid.uuid4().hex[:10]
    reader = client.post("/users", headers={"Authorization": f"Bearer {admin_token}"}, json={
        "name": "Leitor sem permissão", "email": f"{suffix}@example.com",
        "password": "Test-password-123", "role": "reader"
    })
    assert reader.status_code == 201
    reader_token = token_for(client, reader.json()["email"], "Test-password-123")
    response = client.post("/books", headers={"Authorization": f"Bearer {reader_token}"}, json={
        "title": "Não permitido", "author": "Teste", "total_copies": 1
    })
    assert response.status_code == 403
