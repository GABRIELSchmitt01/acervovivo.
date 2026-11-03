# Início da implementação Flutter — AcervoVivo

**Data:** 03/11/2026  
**Etapa:** primeiro esqueleto de interface  
**Situação:** código-fonte inicial registrado; geração dos arquivos nativos, execução e análise ainda pendentes.

## 1. Objetivo

Iniciar a transformação dos protótipos do Figma em um aplicativo Flutter, começando pela estrutura de interface e pela navegação principal. Esta etapa não implementa ainda persistência, autenticação, sincronização ou operações administrativas reais.

## 2. Estrutura criada

A pasta `app_flutter/` contém:

- `pubspec.yaml`: configuração mínima do projeto Flutter;
- `lib/main.dart`: ponto de entrada, tema e navegação inferior;
- `lib/theme/app_theme.dart`: paleta e estilos base;
- `lib/models/book.dart`: modelo de dados de livro;
- `lib/data/sample_books.dart`: livros fictícios usados para demonstrar a interface;
- `lib/screens/home_screen.dart`: tela inicial com categorias e destaques;
- `lib/screens/catalog_screen.dart`: catálogo com pesquisa por título/autor e filtros;
- `lib/screens/history_screen.dart`: estado inicial vazio do histórico;
- `lib/screens/profile_screen.dart`: espaço reservado para identificação;
- `lib/widgets/`: cartão de livro, linha de catálogo, capa e detalhes.

## 3. Funcionalidades de interface desta primeira etapa

- Navegação entre Início, Catálogo, Histórico e Perfil.
- Campo de entrada na tela inicial que leva ao Catálogo.
- Pesquisa por título e autor.
- Filtro por categoria.
- Abertura de detalhes demonstrativos do livro.
- Indicação visual da disponibilidade usando dados fictícios.

## 4. O que ainda não foi implementado

- Banco de dados e persistência dos cadastros.
- Login, identificação e permissões dos dois perfis.
- Cadastro, edição e exclusão de livros.
- Cadastro de usuários.
- Empréstimos, devoluções e histórico real.
- Comunicação entre dispositivos ou sincronização.

Essas funções dependem de decisões sobre o cenário de uso e a arquitetura. Em especial, se bibliotecário e alunos utilizarem dispositivos diferentes, os dados deverão ser compartilhados por uma solução adequada; um banco SQLite isolado em apenas um dispositivo não atenderia esse cenário por si só.

## 5. Como preparar e executar no computador

É necessário ter o Flutter SDK e um dispositivo ou emulador configurado.

1. Abra um terminal na pasta `app_flutter`.
2. Confira se o Flutter está instalado:

   ```bash
   flutter --version
   flutter doctor -v
   ```

3. Gere as pastas nativas para Android e Windows:

   ```bash
   flutter create --platforms=android,windows --project-name acervovivo .
   ```

4. Baixe as dependências:

   ```bash
   flutter pub get
   ```

5. Confira os dispositivos:

   ```bash
   flutter devices
   ```

6. Execute no Windows:

   ```bash
   flutter run -d windows
   ```

   Ou execute no dispositivo Android/emulador usando o identificador mostrado por `flutter devices`.

7. Verifique o código:

   ```bash
   flutter analyze
   flutter test
   ```

A geração dos arquivos nativos e a execução precisam ser feitas no computador que possui o Flutter SDK. Neste ambiente de preparação, o comando `flutter` não está instalado, portanto o código-fonte ainda não foi compilado ou validado pelo analisador.

## 6. Próximas decisões técnicas

Antes de adicionar banco de dados ou login, confirmar:

- se a proposta Flutter foi formalmente aceita em relação ao Formulário 02 do estágio;
- se a biblioteca utilizará um dispositivo administrativo ou vários dispositivos;
- se os alunos consultarão os livros em seus próprios celulares;
- se será necessário armazenamento centralizado e sincronização;
- quais permissões cada perfil terá.

## 7. Resultado desta etapa

Foi criado e registrado um esqueleto inicial de aplicativo Flutter com navegação e telas de consulta demonstrativas. O próximo passo é gerar as plataformas, executar o app no computador, analisar e corrigir eventuais erros e depois fechar a arquitetura dos dados antes de implementar as operações reais.
