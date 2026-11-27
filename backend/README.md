# AcervoVivo API

Backend inicial com FastAPI, PostgreSQL e Docker Compose.

Inclui criação inicial de tabelas, bibliotecário inicial por variáveis de ambiente, login com hash PBKDF2 e token bearer, catálogo público com busca e disponibilidade, CRUD de livros, cadastro/consulta de leitores, empréstimos, devoluções e histórico com escopo por usuário.

## Instalação na VPS
1. Copie `.env.example` para `.env` e preencha senhas fortes.
2. Nunca envie `.env` ao GitHub.
3. Execute `docker compose up -d --build`.
4. Verifique `docker compose ps`, `docker compose logs -f api`.
5. Teste `curl http://127.0.0.1:8000/health`.
6. Configure proxy reverso e HTTPS antes de expor publicamente.

A porta do PostgreSQL não é publicada; o banco fica na rede interna do Docker. O serviço API é publicado apenas em localhost na porta 8000 para ser colocado atrás de HTTPS.

## Endpoints
- `GET /health`
- `POST /auth/login`, `GET /auth/me`
- `GET /books`, `GET /books/{id}`, `POST/PUT/DELETE /books`
- `POST /users`, `GET /users`
- `POST /loans`, `POST /loans/{id}/return`, `GET /loans`

Este é o primeiro incremento. Antes de produção, precisamos testar em ambiente real, adicionar migrações Alembic, testes automatizados, backups e HTTPS, e conectar a interface Flutter à API.
