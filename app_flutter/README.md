# AcervoVivo — aplicativo Flutter (primeira etapa)

Esta pasta contém o primeiro incremento de interface do AcervoVivo em Flutter.

## O que já foi iniciado

- Estrutura de pastas para telas, dados demonstrativos, modelos, tema e widgets.
- Tela inicial baseada no primeiro protótipo do Figma.
- Navegação inferior entre Início, Catálogo, Histórico e Perfil.
- Pesquisa por título ou autor no catálogo.
- Filtros de categoria.
- Visualização demonstrativa dos detalhes de um livro.

## O que ainda não está implementado

- Banco de dados e persistência.
- Login e identificação real de perfis.
- Cadastro e edição de livros e usuários.
- Empréstimos, devoluções e histórico real.
- Sincronização entre vários dispositivos.

Os livros presentes em `lib/data/sample_books.dart` são exemplos fictícios para demonstrar a interface. Não representam dados de uma biblioteca real.

## Preparar o projeto no Windows

É necessário ter Flutter SDK instalado e configurado no PATH.

1. Abra o terminal dentro desta pasta (`app_flutter`).
2. Gere os arquivos de plataforma para Windows e Android:

   ```bash
   flutter create --platforms=windows,android .
   ```

3. Baixe e configure as dependências:

   ```bash
   flutter pub get
   ```

4. Confira os dispositivos disponíveis:

   ```bash
   flutter devices
   ```

5. Para executar no Windows (com suporte a desktop habilitado):

   ```bash
   flutter run -d windows
   ```

   Para executar em um emulador Android ou celular conectado, use o identificador exibido por `flutter devices`.

## Próxima etapa técnica

Antes de conectar um banco de dados, será necessário confirmar com o professor e com o cenário de uso se a biblioteca terá um único dispositivo ou vários dispositivos compartilhados. Essa decisão define se o armazenamento local é suficiente ou se será necessário um serviço sincronizado.
