# Modelo de dados do AcervoVivo

O banco PostgreSQL é compartilhado pela API; o aplicativo não cria um banco isolado por instalação. O volume Docker `postgres_data` mantém os registros entre reinicializações.

## Tabelas

### `users` — leitores e bibliotecários
- `id`: chave primária numérica.
- `name`: nome completo.
- `email`: único, usado no login.
- `phone`: telefone opcional.
- `registration_code`: matrícula/código opcional e único.
- `password_hash`: hash PBKDF2-SHA256 com salt; nunca armazena senha em texto.
- `role`: `reader` ou `librarian`.
- `active`: permite desativar o acesso.
- `created_at`: data de criação.

### `books` — catálogo
- `id`: chave primária.
- `title`, `author`: título e autor, obrigatórios.
- `isbn`: ISBN opcional e único quando informado.
- `category`: categoria/gênero.
- `publication_year`: ano opcional (0 a 2100).
- `total_copies`: quantidade total de exemplares, não negativa.
- `publisher`: editora.
- `description`: descrição opcional.
- `created_at`: data de criação.

### `loans` — circulação
- `id`: chave primária.
- `book_id`: chave estrangeira para `books.id`.
- `user_id`: chave estrangeira para `users.id`.
- `loan_date`: data do empréstimo.
- `due_date`: data prevista de devolução, não anterior ao empréstimo.
- `returned_at`: data real da devolução; nula enquanto aberto.
- `created_at`: data de registro.

## Relacionamentos
- Um leitor pode ter vários empréstimos.
- Um livro pode aparecer em vários empréstimos ao longo do tempo.
- Um empréstimo pertence a um único livro e a um único leitor.
- Livros e usuários relacionados a empréstimos não são removidos em cascata; o histórico é preservado.

## Regras de negócio
1. O catálogo pode ser consultado por usuários autenticados.
2. Apenas bibliotecários podem cadastrar/editar/excluir livros, cadastrar leitores e registrar/devolver empréstimos.
3. O histórico do leitor é filtrado pela conta autenticada; bibliotecários podem consultar o histórico geral.
4. A disponibilidade é calculada como `total_copies - empréstimos sem returned_at`.
5. Não é permitido emprestar quando não há exemplares disponíveis.
6. Não é permitido excluir livro com empréstimo em aberto.
7. A API valida dados e o banco também possui restrições de integridade para quantidade, ano, ISBN único e datas.

## Inicialização
Na primeira subida, a API cria as tabelas automaticamente e registra um bibliotecário inicial com as variáveis `BOOTSTRAP_LIBRARIAN_*`. Para mudanças futuras no esquema, usar migrações versionadas (Alembic); `create_all` não altera automaticamente tabelas já existentes.
