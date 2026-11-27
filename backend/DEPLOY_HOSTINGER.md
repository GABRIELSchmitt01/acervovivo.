# Implantação do AcervoVivo na VPS Hostinger

Este guia implanta a API e o PostgreSQL. O banco fica somente na rede Docker; não abra a porta 5432 no firewall.

## 1. Preparar a pasta do projeto

Entre na VPS por SSH ou no Console da Hostinger e execute:

```bash
apt update
apt install -y git nginx certbot python3-certbot-nginx
mkdir -p /opt/acervovivo
cd /opt
git clone https://github.com/GABRIELSchmitt01/acervovivo..git
cd /opt/acervovivo
git checkout feature/backend-postgres-api
cd backend
```

O nome do repositório no GitHub termina com ponto; por isso o endereço de clone tem dois pontos antes de `.git`.

## 2. Criar as configurações secretas

Crie o arquivo local `.env` a partir do exemplo:

```bash
cp .env.example .env
nano .env
```

Preencha os campos. Gere valores aleatórios seguros no próprio servidor, por exemplo:

```bash
openssl rand -hex 32
```

Use um valor diferente para `POSTGRES_PASSWORD`, `APP_SECRET_KEY` e `BOOTSTRAP_LIBRARIAN_PASSWORD`. Senhas hexadecimais geradas por esse comando evitam caracteres que poderiam quebrar a URL de conexão do PostgreSQL.

Exemplo de nomes de variáveis (não copie valores de exemplo para produção):

```dotenv
POSTGRES_DB=acervovivo
POSTGRES_USER=acervovivo
POSTGRES_PASSWORD=COLE_UM_SEGREDO_HEX
APP_SECRET_KEY=COLE_OUTRO_SEGREDO_HEX
BOOTSTRAP_LIBRARIAN_NAME=Bibliotecario
BOOTSTRAP_LIBRARIAN_EMAIL=SEU_EMAIL
BOOTSTRAP_LIBRARIAN_PASSWORD=COLE_UMA_SENHA_FORTE
CORS_ORIGINS=*
```

Salve no nano com Ctrl+O, Enter e Ctrl+X. Proteja o arquivo:

```bash
chmod 600 .env
```

**Nunca faça commit nem envie o arquivo `.env` ao GitHub.** Ele contém as credenciais reais do banco e do bibliotecário.

## 3. Iniciar API e banco

Na pasta `/opt/acervovivo/backend`:

```bash
docker compose up -d --build
docker compose ps
docker compose logs -f api
```

A primeira inicialização cria automaticamente as tabelas e o bibliotecário inicial a partir das variáveis do `.env`. O volume `postgres_data` mantém os dados mesmo se os containers forem recriados.

Teste na VPS:

```bash
curl http://127.0.0.1:8000/health
```

Deve retornar um JSON com `"status":"ok"`. A documentação interativa da API fica em `http://127.0.0.1:8000/docs` acessível localmente na VPS.

## 4. Configurar domínio e HTTPS

A API está ligada a `127.0.0.1:8000` intencionalmente; não exponha essa porta diretamente. Configure um domínio/subdomínio (por exemplo, `api.seudominio.com`) com registro DNS tipo A apontando para o IP da VPS.

Crie uma configuração Nginx em `/etc/nginx/sites-available/acervovivo-api`:

```nginx
server {
    listen 80;
    server_name api.seudominio.com;

    location / {
        proxy_pass http://127.0.0.1:8000;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

Troque `api.seudominio.com` pelo domínio configurado. Ative o site e obtenha o certificado:

```bash
ln -s /etc/nginx/sites-available/acervovivo-api /etc/nginx/sites-enabled/acervovivo-api
nginx -t
systemctl reload nginx
certbot --nginx -d api.seudominio.com
```

Só use a API com o aplicativo após o HTTPS estar funcionando. Mantenha as portas 80 e 443 liberadas; não libere 5432 nem 8000 publicamente.

## 5. Gerar o APK apontando para a API

Na pasta do Flutter, configure o endereço HTTPS real:

```bash
flutter pub get
flutter build apk --release --dart-define=API_BASE_URL=https://api.seudominio.com
```

Para emulador Android local sem HTTPS, o padrão de desenvolvimento é `http://10.0.2.2:8000`. Em celular físico, use o domínio HTTPS público.

## 6. Backup básico do banco

Crie um backup antes de atualizações:

```bash
cd /opt/acervovivo/backend
mkdir -p backups
docker compose exec -T db pg_dump -U "$POSTGRES_USER" "$POSTGRES_DB" > "backups/acervovivo-$(date +%F-%H%M).sql"
```

Para usar as variáveis no comando, carregue o arquivo `.env` na sessão primeiro (`set -a; . ./.env; set +a`). Guarde os backups fora da VPS também.

## Estado do deploy

Este documento descreve o processo planejado. Após a implantação, confirme health check, login do bibliotecário, criação de livro/leitor, empréstimo e devolução, e acesso ao mesmo catálogo em dois dispositivos antes de considerar o serviço pronto para uso.
