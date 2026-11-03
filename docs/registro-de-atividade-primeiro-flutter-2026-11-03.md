# Registro de atividade — Primeira estrutura do aplicativo Flutter

**Data:** 03/11/2026  
**Projeto:** AcervoVivo — Sistema de Controle de Biblioteca  
**Etapa:** Início da implementação da interface Flutter  
**Situação:** código-fonte inicial registrado no GitHub; execução e análise local pendentes.

## Objetivo

Iniciar a transformação dos protótipos do AcervoVivo em código Flutter, preparando uma estrutura de aplicativo e implementando a navegação e as primeiras telas de consulta.

## Atividades realizadas

- Criação da configuração inicial do pacote Flutter em `app_flutter/pubspec.yaml`.
- Organização do código em pastas para modelos, dados demonstrativos, telas, tema e componentes visuais.
- Criação do ponto de entrada do aplicativo em `lib/main.dart`.
- Definição da paleta visual e dos estilos gerais com base no protótipo do Figma.
- Criação do modelo inicial de livro.
- Criação de dados fictícios para demonstrar o catálogo.
- Implementação da navegação inferior entre Início, Catálogo, Histórico e Perfil.
- Implementação da tela inicial com destaques e filtros por categoria.
- Implementação do catálogo com busca por título e autor e filtros por categoria.
- Implementação da visualização demonstrativa de detalhes do livro.
- Criação de componentes reutilizáveis para capas, cartões e linhas de livros.
- Criação de telas iniciais de histórico e perfil, indicando que esses recursos ainda não possuem dados reais.
- Registro de instruções para gerar as plataformas Android e Windows e executar o projeto localmente.

## Arquivos de evidência

- [Pasta do aplicativo Flutter](../tree/main/app_flutter)
- [Ponto de entrada](../blob/main/app_flutter/lib/main.dart)
- [Tela inicial](../blob/main/app_flutter/lib/screens/home_screen.dart)
- [Catálogo](../blob/main/app_flutter/lib/screens/catalog_screen.dart)
- [Tema visual](../blob/main/app_flutter/lib/theme/app_theme.dart)
- [Guia de preparação e execução](inicio-do-desenvolvimento-flutter.md)
- [Issue de acompanhamento da implementação](https://github.com/GABRIELSchmitt01/acervovivo./issues/9)

## Resultado produzido

Foi registrado o primeiro esqueleto de interface do AcervoVivo em Flutter. A navegação entre quatro áreas está definida no código, a busca e os filtros do catálogo funcionam com dados temporários e os detalhes de livros podem ser visualizados em uma folha de detalhes.

## Limitações desta etapa

O código ainda não foi compilado ou executado em um dispositivo. Neste ambiente de preparação, o Flutter SDK não está instalado. Também não existe banco de dados conectado, login, sincronização, cadastro persistente, empréstimos ou devoluções funcionais.

Os livros utilizados são dados fictícios para demonstração da interface.

## Próximas atividades técnicas

- [ ] Conferir o Flutter SDK no computador.
- [ ] Gerar as pastas nativas Android e Windows.
- [ ] Baixar as dependências.
- [ ] Executar análise estática e testes.
- [ ] Rodar o app em Windows ou Android.
- [ ] Corrigir os erros encontrados.
- [ ] Confirmar armazenamento e sincronização antes de desenvolver persistência.

## Registro do tempo efetivamente dedicado

**Horário de início:** ____________________  
**Horário de término:** ____________________  
**Tempo efetivamente trabalhado:** ____________________

> Preencher os horários e a duração conforme o trabalho realmente realizado e o procedimento exigido pela instituição. Este registro descreve o que foi preparado, mas não declara uma quantidade de horas sem apontamento real.
