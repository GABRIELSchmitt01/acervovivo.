# AcervoVivo — Sistema de Controle de Biblioteca

O AcervoVivo é um projeto acadêmico do Estágio Supervisionado Obrigatório do curso de Análise e Desenvolvimento de Sistemas da FASEC. A proposta é desenvolver um aplicativo para organizar o acervo de livros físicos, os usuários, os empréstimos e as devoluções de bibliotecas. O sistema poderá ser utilizado por bibliotecas em geral, tendo como foco principal os contextos de escolas, faculdades e universidades, onde alunos, professores e outros frequentadores consultam e utilizam o acervo.

## O que o sistema pretende fazer

- Cadastrar, consultar, alterar e excluir livros.
- Cadastrar e consultar usuários.
- Registrar empréstimos e devoluções.
- Permitir que o usuário comum consulte os livros e seu próprio histórico de empréstimos.
- Manter os dados organizados em um banco de dados.

O foco inicial é o gerenciamento de livros físicos e de sua circulação dentro da biblioteca. O AcervoVivo não está sendo planejado como uma plataforma de leitura ou download de livros em PDF. Essas funcionalidades ainda fazem parte do planejamento e serão desenvolvidas e testadas durante o projeto.

## Documentação

A documentação está na pasta [docs](docs/):

- [Análise de Requisitos](docs/analise-de-requisitos.md)
- [Modelagem Inicial do Banco de Dados](docs/modelagem-banco-de-dados.md)
- [Planejamento do Projeto](docs/planejamento-do-projeto.md)
- [Especificação funcional e fluxos de uso](docs/especificacao-funcional-e-fluxos.md)
- [Registro de atividade — 02/11/2026](docs/registro-de-atividade-2026-11-02.md)
- [Protótipo e fluxos de navegação — 03/11/2026](docs/prototipo-e-fluxos-de-navegacao.md)
- [Registro de atividade — 03/11/2026](docs/registro-de-atividade-2026-11-03.md)

## Tecnologia e escopo atual

A proposta atual é desenvolver um aplicativo em Flutter. Uma versão web não faz parte do escopo neste momento; é apenas uma ideia para o futuro, ainda sem confirmação.

Há uma diferença entre essa proposta e o Formulário 02 da FASEC, que descreve um sistema web e cita FastAPI e SQLAlchemy. Essa diferença precisa ser confirmada com o professor orientador antes da entrega final. Por enquanto, o planejamento do produto será voltado ao aplicativo Flutter, sem iniciar uma API ou uma versão web.

## Aplicativo Flutter

O primeiro esqueleto de interface está na pasta [app_flutter](app_flutter/). Ele contém navegação inicial, tela de início, catálogo com busca e filtros, detalhes demonstrativos, histórico vazio e perfil reservado. Os dados ainda são fictícios e não existe persistência ou login nesta etapa. Consulte o [guia de início da implementação](docs/inicio-do-desenvolvimento-flutter.md) para preparar e executar o projeto no computador.

## Acompanhamento do projeto

O andamento das atividades está organizado no [Kanban do AcervoVivo](KANBAN.md), com tarefas concluídas, em andamento, pendentes e itens que ainda precisam de avaliação.

## Próximas etapas

- [x] Criar o repositório do projeto.
- [x] Registrar a primeira versão da análise de requisitos.
- [x] Criar uma proposta inicial de modelagem do banco de dados.
- [x] Registrar o planejamento inicial do aplicativo Flutter.
- [ ] Confirmar com o professor a adequação da proposta Flutter ao Formulário 02.
- [ ] Validar os campos, relacionamentos e regras de negócio.
- [ ] Criar o banco de dados na tecnologia aprovada.
- [ ] Desenvolver as funcionalidades.
- [ ] Testar o sistema e corrigir os problemas encontrados.

> Este repositório está em fase inicial. A documentação registra o planejamento; as funcionalidades ainda precisam ser implementadas e testadas.
