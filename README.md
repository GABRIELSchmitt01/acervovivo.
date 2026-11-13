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
- [Registro de atividade — prototipação 03/11/2026](docs/registro-de-atividade-2026-11-03.md)
- [Registro de atividade — primeira implementação Flutter 03/11/2026](docs/registro-de-atividade-primeiro-flutter-2026-11-03.md)
- [Registro de decisão — autorização para uso de Flutter (13/11/2026)](docs/registro-de-decisao-flutter-2026-11-13.md)

## Tecnologia e escopo atual

A proposta atual é desenvolver um aplicativo em Flutter. Uma versão web não faz parte do escopo neste momento; é apenas uma ideia para o futuro, ainda sem confirmação.

A utilização do Flutter foi confirmada pelo professor orientador, conforme comunicação do estudante em 13/11/2026. A decisão está registrada em [Registro de decisão — autorização para uso de Flutter](docs/registro-de-decisao-flutter-2026-11-13.md). O aplicativo já foi executado no Chrome em ambiente local para validar a interface; essa execução de teste não define, por si só, a arquitetura final de dados ou a plataforma de entrega.

## Aplicativo Flutter

O aplicativo em Flutter está na pasta [app_flutter](app_flutter/). A primeira versão foi executada localmente no Chrome em 13/11/2026, e o estudante confirmou o funcionamento da navegação principal e dos filtros do catálogo. Os livros continuam sendo dados demonstrativos; ainda não há persistência, login real, empréstimos ou sincronização. Consulte o [guia de início da implementação](docs/inicio-do-desenvolvimento-flutter.md) para preparar e executar o projeto no computador.

## Acompanhamento do projeto

O andamento das atividades está organizado no [Kanban do AcervoVivo](KANBAN.md), com tarefas concluídas, em andamento, pendentes e itens que ainda precisam de avaliação.

## Próximas etapas

- [x] Criar o repositório do projeto.
- [x] Registrar a primeira versão da análise de requisitos.
- [x] Criar uma proposta inicial de modelagem do banco de dados.
- [x] Registrar o planejamento inicial do aplicativo Flutter.
- [x] Confirmar com o professor a autorização para atualizar a proposta e utilizar Flutter (registro de 13/11/2026).
- [ ] Validar os campos, relacionamentos e regras de negócio.
- [ ] Definir armazenamento e sincronização para compartilhar os dados entre dispositivos, se necessário.
- [ ] Definir e criar o banco de dados após a decisão de arquitetura e sincronização.
- [ ] Desenvolver as funcionalidades.
- [ ] Testar o sistema e corrigir os problemas encontrados.

> Este repositório está em fase inicial. A documentação registra o planejamento; as funcionalidades ainda precisam ser implementadas e testadas.
