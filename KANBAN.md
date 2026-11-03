# Kanban — AcervoVivo

> Quadro de acompanhamento do projeto. Atualize o status dos cartões conforme o trabalho realmente avançar.
>
> **Público e cenário de uso:** sistema para bibliotecas em geral, com foco prioritário em bibliotecas de escolas, faculdades e universidades. A primeira versão considera o controle de livros físicos, usuários, empréstimos e devoluções; não é uma plataforma de PDFs. A confirmação da proposta Flutter em relação ao Formulário 02 ainda está pendente.
>
> **Como usar:** cada cartão pendente está vinculado a uma issue do GitHub. Ao iniciar uma tarefa, mova-a para **Em andamento** neste arquivo. Ao concluir, mova-a para **Concluído** e feche a issue correspondente. Não marque tarefas como concluídas sem implementação ou validação.

## Concluído

- [x] Criar o repositório e organizar o README — [README.md](README.md)
- [x] Elaborar a análise inicial de requisitos — [docs/analise-de-requisitos.md](docs/analise-de-requisitos.md)
- [x] Elaborar a modelagem inicial do banco de dados — [docs/modelagem-banco-de-dados.md](docs/modelagem-banco-de-dados.md)
- [x] Elaborar o planejamento inicial do aplicativo — [docs/planejamento-do-projeto.md](docs/planejamento-do-projeto.md)
- [x] Criar a primeira tela inicial editável no Figma, com filtros e cartões de livros reutilizáveis — [Abrir tela no Figma](https://www.figma.com/design/eanAee98wCyRSHrNTa1q9C?node-id=2-30)
- [x] Criar primeira rodada do fluxo e das telas complementares no Figma (nove telas, dois fluxos e componentes reutilizáveis) — [Abrir protótipos](https://www.figma.com/design/eanAee98wCyRSHrNTa1q9C?node-id=14-31) e [documentação](docs/prototipo-e-fluxos-de-navegacao.md)
- [x] Registrar a atividade de prototipação de 03/11/2026 — [Registro de atividade](docs/registro-de-atividade-2026-11-03.md)
- [x] Elaborar a especificação funcional v0.1, com perfis, telas, fluxos, regras, validações e cenários de teste — [Documento](docs/especificacao-funcional-e-fluxos.md)
- [x] Registrar a atividade documental de 02/11/2026 e preparar campo para apontamento do tempo real — [Registro de atividade](docs/registro-de-atividade-2026-11-02.md)
- [x] Preparar o primeiro esqueleto de código Flutter, com navegação, tela inicial, catálogo, busca e filtros — [Código](app_flutter/) e [guia de execução](docs/inicio-do-desenvolvimento-flutter.md)
- [x] Registrar a primeira atividade de implementação Flutter — [Registro de atividade](docs/registro-de-atividade-primeiro-flutter-2026-11-03.md)

## Em andamento

- [ ] [#9 — Preparar e executar a primeira versão do aplicativo](https://github.com/GABRIELSchmitt01/acervovivo./issues/9) — em andamento: esqueleto de código registrado; falta gerar as plataformas, executar e validar no computador.

## A fazer

### Definições e decisões antes de programar

- [ ] [#1 — Confirmar proposta Flutter em relação ao Formulário 02](https://github.com/GABRIELSchmitt01/acervovivo./issues/1)
- [ ] [#2 — Definir perfis, identificação, login e permissões](https://github.com/GABRIELSchmitt01/acervovivo./issues/2)
- [ ] [#3 — Validar campos do cadastro de usuários](https://github.com/GABRIELSchmitt01/acervovivo./issues/3)
- [ ] [#4 — Definir regras de empréstimo e devolução](https://github.com/GABRIELSchmitt01/acervovivo./issues/4)
- [ ] [#5 — Decidir controle por quantidade ou por exemplar individual](https://github.com/GABRIELSchmitt01/acervovivo./issues/5)
- [ ] [#6 — Definir regra para exclusão de livros com empréstimos](https://github.com/GABRIELSchmitt01/acervovivo./issues/6)
- [ ] [#7 — Escolher armazenamento e necessidade de sincronização](https://github.com/GABRIELSchmitt01/acervovivo./issues/7)

### Design e construção do aplicativo

- [ ] [#10 — Implementar persistência dos dados](https://github.com/GABRIELSchmitt01/acervovivo./issues/10)
- [ ] [#11 — Implementar cadastro, consulta, edição e exclusão de livros](https://github.com/GABRIELSchmitt01/acervovivo./issues/11)
- [ ] [#12 — Implementar cadastro e consulta de usuários](https://github.com/GABRIELSchmitt01/acervovivo./issues/12)
- [ ] [#13 — Implementar registro de empréstimos e devoluções](https://github.com/GABRIELSchmitt01/acervovivo./issues/13)
- [ ] [#14 — Implementar consulta do histórico de empréstimos](https://github.com/GABRIELSchmitt01/acervovivo./issues/14)

### Validação e entrega

- [ ] [#15 — Testar funcionalidades e regras de integridade](https://github.com/GABRIELSchmitt01/acervovivo./issues/15)
- [ ] [#16 — Atualizar documentos e registrar evidências finais](https://github.com/GABRIELSchmitt01/acervovivo./issues/16)
- [ ] [#18 — Revisar e validar a especificação funcional v0.1](https://github.com/GABRIELSchmitt01/acervovivo./issues/18)

## A avaliar (não faz parte do escopo aprovado)

- [ ] [#17 — Avaliar se reserva de livros fará parte da primeira versão](https://github.com/GABRIELSchmitt01/acervovivo./issues/17)

> **Nota sobre reservas:** a funcionalidade de reserva foi discutida como uma possível melhoria, mas não consta como requisito aprovado na documentação atual. Só deve entrar no escopo depois de decisão com o professor e atualização dos requisitos e do planejamento.

## Visão rápida do fluxo

1. Confirmar o escopo e resolver as decisões pendentes.
2. Finalizar o fluxo de navegação e as telas.
3. Criar o projeto Flutter e definir o armazenamento.
4. Implementar livros e usuários.
5. Implementar empréstimos, devoluções e histórico.
6. Testar, corrigir e atualizar a documentação.

## Referências do projeto

- [README](README.md)
- [Análise de requisitos](docs/analise-de-requisitos.md)
- [Modelagem inicial do banco de dados](docs/modelagem-banco-de-dados.md)
- [Planejamento do projeto](docs/planejamento-do-projeto.md)
- [Protótipo inicial no Figma](https://www.figma.com/design/eanAee98wCyRSHrNTa1q9C?node-id=2-30)
