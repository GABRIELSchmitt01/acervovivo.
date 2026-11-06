# Kanban — AcervoVivo

> Quadro de acompanhamento do projeto. Os status abaixo refletem o que já foi produzido no repositório e o que ainda depende de execução ou decisão.
>
> **Público e cenário de uso:** sistema para bibliotecas em geral, com foco prioritário em escolas, faculdades e universidades. A primeira versão considera o controle de livros físicos, usuários, empréstimos e devoluções; não é uma plataforma de PDFs.
>
> **Atenção ao escopo:** o Formulário 02 descreve um sistema web com FastAPI e SQLAlchemy, enquanto a proposta atual está sendo preparada em Flutter. A confirmação do professor ainda está pendente na Issue #1. Não considere a tecnologia formalmente aprovada até essa orientação ser registrada.
>
> **Como usar:** cada item abaixo corresponde a uma Issue. Mova os cartões no GitHub Projects conforme o trabalho real avançar. Feche uma Issue apenas quando os critérios de conclusão forem atendidos. O arquivo `KANBAN.md` é um resumo documental; ele não altera automaticamente as colunas do quadro nativo do GitHub Projects.

## Concluído

- [x] Repositório e README inicial — [README.md](README.md)
- [x] Análise inicial de requisitos — [documento](docs/analise-de-requisitos.md)
- [x] Modelagem inicial de dados — [documento](docs/modelagem-banco-de-dados.md)
- [x] Planejamento inicial — [documento](docs/planejamento-do-projeto.md)
- [x] Especificação funcional v0.1 — [documento](docs/especificacao-funcional-e-fluxos.md)
- [x] Protótipo no Figma: tela inicial, nove telas complementares, dois fluxos e biblioteca de componentes — [tela inicial](https://www.figma.com/design/eanAee98wCyRSHrNTa1q9C?node-id=2-30) · [telas complementares](https://www.figma.com/design/eanAee98wCyRSHrNTa1q9C?node-id=14-31)
- [x] Separar as instâncias do Figma para permitir selecionar e editar individualmente textos, campos, botões, filtros e cartões — componentes-base originais preservados.
- [x] Guia para preparar e executar a base Flutter — [guia](docs/inicio-do-desenvolvimento-flutter.md)
- [x] Esqueleto inicial Flutter no repositório: navegação, tela inicial, catálogo, busca, filtros e dados fictícios — [código](app_flutter/)
- [x] Registros de atividades já iniciadas — [02/11](docs/registro-de-atividade-2026-11-02.md), [03/11](docs/registro-de-atividade-2026-11-03.md) e [primeira atividade Flutter](docs/registro-de-atividade-primeiro-flutter-2026-11-03.md)

**Issue concluída:** [#8 — Prototipar telas e fluxos no Figma](https://github.com/GABRIELSchmitt01/acervovivo./issues/8).

## Em andamento

- [ ] [#9 — Preparar e executar a primeira versão do aplicativo](https://github.com/GABRIELSchmitt01/acervovivo./issues/9)  
  A estrutura inicial está no repositório. Falta executar no computador: verificar Flutter, gerar as plataformas Android/Windows, obter dependências, analisar, testar e abrir o app. Ainda não foi confirmado que compila ou roda localmente.

## A fazer — decisões prioritárias

Estas decisões devem ser resolvidas antes de fechar a arquitetura e implementar funcionalidades reais.

- [ ] [#1 — Confirmar proposta Flutter em relação ao Formulário 02](https://github.com/GABRIELSchmitt01/acervovivo./issues/1) — **prioridade máxima / bloqueador acadêmico**.
- [ ] [#2 — Definir perfis, identificação, login e permissões](https://github.com/GABRIELSchmitt01/acervovivo./issues/2).
- [ ] [#3 — Validar campos do cadastro de usuários](https://github.com/GABRIELSchmitt01/acervovivo./issues/3).
- [ ] [#4 — Definir regras de empréstimo e devolução](https://github.com/GABRIELSchmitt01/acervovivo./issues/4).
- [ ] [#5 — Decidir controle por quantidade ou por exemplar individual](https://github.com/GABRIELSchmitt01/acervovivo./issues/5).
- [ ] [#6 — Definir regra para exclusão de livros com empréstimos](https://github.com/GABRIELSchmitt01/acervovivo./issues/6).
- [ ] [#7 — Escolher armazenamento e necessidade de sincronização](https://github.com/GABRIELSchmitt01/acervovivo./issues/7) — **prioridade alta**, especialmente se diferentes dispositivos precisarem compartilhar os mesmos dados.

## A fazer — implementação

- [ ] [#19 — Implementar no Flutter as telas do protótipo Figma](https://github.com/GABRIELSchmitt01/acervovivo./issues/19) — próxima etapa de interface após validar a base da Issue #9. O escopo é visual e de navegação; não inclui persistência ou autenticação real.
- [ ] [#10 — Implementar persistência dos dados](https://github.com/GABRIELSchmitt01/acervovivo./issues/10) — depende das decisões de arquitetura e modelagem.
- [ ] [#11 — Implementar cadastro, consulta, edição e exclusão de livros](https://github.com/GABRIELSchmitt01/acervovivo./issues/11).
- [ ] [#12 — Implementar cadastro e consulta de usuários](https://github.com/GABRIELSchmitt01/acervovivo./issues/12).
- [ ] [#13 — Implementar empréstimos e devoluções](https://github.com/GABRIELSchmitt01/acervovivo./issues/13).
- [ ] [#14 — Implementar consulta do histórico de empréstimos](https://github.com/GABRIELSchmitt01/acervovivo./issues/14).

## A fazer — revisão, testes e entrega

- [ ] [#18 — Revisar e validar a especificação funcional v0.1](https://github.com/GABRIELSchmitt01/acervovivo./issues/18).
- [ ] [#15 — Testar funcionalidades e regras de integridade](https://github.com/GABRIELSchmitt01/acervovivo./issues/15).
- [ ] [#16 — Atualizar documentos e registrar evidências finais](https://github.com/GABRIELSchmitt01/acervovivo./issues/16).

## A avaliar — fora do escopo confirmado

- [ ] [#17 — Avaliar se reserva de livros fará parte da primeira versão](https://github.com/GABRIELSchmitt01/acervovivo./issues/17).

A reserva é apenas uma possibilidade discutida. Não deve entrar na primeira versão sem avaliação, aprovação e atualização dos requisitos.

## Ordem recomendada de trabalho

1. Resolver a confirmação do escopo com o professor (Issue #1).
2. Executar e validar a base Flutter no computador (Issue #9).
3. Definir armazenamento, sincronização, perfis e regras principais (Issues #2 a #7).
4. Implementar as interfaces Flutter do protótipo (Issue #19).
5. Implementar persistência e operações de livros, usuários, empréstimos e histórico (Issues #10 a #14).
6. Testar, corrigir e fechar a documentação para entrega (Issues #15, #16 e #18).

## Referências

- [README](README.md)
- [Análise de requisitos](docs/analise-de-requisitos.md)
- [Modelagem de dados](docs/modelagem-banco-de-dados.md)
- [Planejamento](docs/planejamento-do-projeto.md)
- [Especificação funcional](docs/especificacao-funcional-e-fluxos.md)
- [Protótipo Figma](https://www.figma.com/design/eanAee98wCyRSHrNTa1q9C?node-id=2-30)
- [Diretório Flutter](app_flutter/)
- [Issues do repositório](https://github.com/GABRIELSchmitt01/acervovivo./issues)
