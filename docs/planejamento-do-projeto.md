# Planejamento do Projeto — AcervoVivo

**Projeto:** Aplicativo de controle de biblioteca  
**Curso:** Análise e Desenvolvimento de Sistemas — FASEC  
**Modalidade:** Projeto + Produto Computacional  
**Versão:** 1.0 — planejamento inicial  
**Data:** 20/10/2026

## 1. Objetivo do planejamento

Este documento organiza os próximos passos para desenvolver o AcervoVivo. A ideia é trabalhar por etapas, definindo o que será feito, quais ferramentas poderão ser usadas e como as funcionalidades serão implementadas e testadas.

Este planejamento é inicial e poderá ser ajustado depois da revisão dos requisitos e das orientações do professor.

## 2. Escopo atual

Neste momento, a proposta é desenvolver **um aplicativo em Flutter** para auxiliar no gerenciamento de bibliotecas em geral. O foco principal de utilização será em bibliotecas de escolas, faculdades e universidades, mas o sistema não será exclusivo dessas instituições.

O cenário de referência considera o controle de livros físicos: o bibliotecário organiza o acervo e registra empréstimos e devoluções, enquanto alunos, professores ou outros frequentadores consultam os livros e seu próprio histórico. A proposta não é criar uma plataforma para leitura ou download de livros em PDF.

As funcionalidades planejadas são:

- Cadastrar, consultar, alterar e excluir livros.
- Cadastrar e consultar usuários pelo perfil de bibliotecário.
- Registrar empréstimos e devoluções.
- Consultar os livros cadastrados.
- Permitir que um usuário comum consulte o próprio histórico de empréstimos.
- Manter os dados organizados e controlar a disponibilidade dos exemplares.

Uma versão web é apenas uma possibilidade futura e não faz parte do escopo atual. Por enquanto, também não está previsto criar uma API ou um backend separado.

## 3. Tecnologias em consideração

| Tecnologia | Uso planejado | Situação |
|---|---|---|
| Flutter | Construir a interface e a aplicação. | Aprovada pelo professor orientador, conforme confirmação comunicada pelo estudante em 13/11/2026. |
| Dart | Linguagem usada no desenvolvimento Flutter. | Prevista com Flutter. |
| SQLite com o pacote sqflite | Possível opção para armazenar os dados localmente no dispositivo. | Proposta a confirmar antes da implementação. |
| GitHub | Guardar código e documentação do projeto. | Já está sendo usado. |
| Visual Studio Code ou Android Studio | Editar, executar e depurar o aplicativo. | Ferramenta de trabalho a definir conforme o ambiente disponível. |

### Observação sobre armazenamento local

Se o aplicativo funcionar sem servidor ou API, uma opção é manter os dados em um banco local no próprio dispositivo. Isso permite guardar livros, usuários e empréstimos naquele dispositivo, mas não sincroniza automaticamente os dados com outros celulares ou computadores.

Por isso, antes de implementar o armazenamento, será necessário confirmar se o uso local atende ao objetivo do projeto. A escolha de SQLite/sqflite é uma proposta, não uma decisão técnica definitiva.

## 4. Perfis previstos

### Bibliotecário

Deverá ter acesso às funções de gerenciamento de livros e usuários, além do registro de empréstimos e devoluções.

### Usuário comum

Deverá poder consultar os livros e o próprio histórico de empréstimos. Em escolas e instituições de ensino superior, esse perfil poderá representar alunos, professores e outros frequentadores autorizados. Em outros tipos de biblioteca, poderá representar leitores ou associados.

A forma como o aplicativo identificará cada perfil, fará o login e protegerá o histórico ainda precisa ser especificada. Não será implementado um mecanismo de autenticação antes de definir essa parte.

## 5. Telas que poderão fazer parte da primeira versão

A lista abaixo é uma proposta inicial para organizar o desenho das telas. A quantidade e o conteúdo poderão mudar durante a prototipação. As telas consideram o gerenciamento de livros físicos em bibliotecas de diferentes tipos, com os cenários escolares e universitários como principal referência.

1. **Tela de acesso ou identificação:** entrada no aplicativo e identificação do perfil, conforme a solução que for definida.
2. **Tela inicial:** atalhos para as principais funções disponíveis ao perfil.
3. **Consulta de livros:** lista e busca dos livros cadastrados.
4. **Cadastro e edição de livros:** formulário com os campos definidos na análise de requisitos.
5. **Consulta e cadastro de usuários:** funções administrativas do bibliotecário.
6. **Registro de empréstimo:** seleção do usuário e do livro e registro das datas.
7. **Devolução de livro:** localização de um empréstimo em aberto e registro da devolução.
8. **Histórico de empréstimos:** consulta ao histórico do próprio usuário e, se necessário, visualização administrativa pelo bibliotecário.

**Andamento do protótipo em 03/11/2026:** foi criada uma primeira rodada de prototipação no Figma, com uma página complementar contendo o fluxo do usuário comum, o fluxo do bibliotecário e nove telas editáveis: seleção de perfil (conceitual), catálogo, detalhes do livro, painel do bibliotecário, cadastro de livro, cadastro de usuário, novo empréstimo, empréstimos em aberto/devolução e histórico. Também foram criados componentes reutilizáveis para campos, botões e linhas do catálogo. A [documentação do protótipo e dos fluxos](prototipo-e-fluxos-de-navegacao.md) registra os detalhes. A tela de seleção de perfil é apenas conceitual: login e permissões ainda precisam ser definidos. Os dados exibidos são demonstrativos; nenhuma função está conectada a banco de dados.

## 6. Organização sugerida do projeto

O código poderá ser organizado por responsabilidade, mantendo separadas a interface, os modelos de dados e o acesso ao armazenamento. Uma estrutura inicial possível é:

```text
lib/
  main.dart
  models/
  screens/
  widgets/
  services/
```

A estrutura final será definida quando o projeto Flutter for criado. Se for adotado armazenamento local, a parte de acesso ao banco poderá ficar em uma classe ou serviço específico, evitando misturar comandos de banco diretamente nas telas.

## 7. Ordem de execução prevista

1. Revisar os requisitos e a proposta de modelagem.
2. Definir como os usuários serão identificados e quais permissões cada perfil terá.
3. Confirmar se o armazenamento local é adequado à primeira versão.
4. Desenhar o fluxo de navegação e os primeiros wireframes das telas — **primeira rodada concluída em 03/11/2026; revisão e validação continuam pendentes.**
5. Criar o projeto Flutter e organizar a estrutura inicial.
6. Implementar o armazenamento e as operações de livros.
7. Implementar o cadastro e a consulta de usuários.
8. Implementar empréstimos, devoluções e histórico.
9. Testar as funcionalidades principais, corrigir problemas e documentar os resultados.

## 8. Critérios iniciais de conclusão

A primeira versão poderá ser considerada funcional quando for possível:

- Cadastrar e consultar livros.
- Alterar e excluir livros de acordo com as regras definidas.
- Cadastrar e consultar usuários por meio das funções do bibliotecário.
- Registrar empréstimos e devoluções.
- Consultar o histórico correspondente ao usuário identificado.
- Manter os dados salvos após fechar e abrir o aplicativo, caso seja aprovado o armazenamento local.
- Executar os testes das funções principais e registrar os resultados.

Esses critérios são metas de trabalho para o projeto e ainda poderão ser ajustados.

## 9. Pontos que permanecem pendentes

- Definir o mecanismo de identificação e acesso dos dois perfis.
- Confirmar se o armazenamento local atende à necessidade do projeto.
- Revisar e validar a primeira rodada de telas e fluxos no Figma com base nas decisões finais de perfis e regras.
- Definir o armazenamento e a necessidade de sincronização entre dispositivos (ver Issue #7).

## 10. Próxima atividade

A autorização para utilizar Flutter foi comunicada pelo estudante em 13/11/2026 e está registrada em `docs/registro-de-decisao-flutter-2026-11-13.md`. A base Flutter já foi executada no Chrome e a navegação principal foi conferida. A próxima atividade é definir armazenamento e sincronização, perfis, permissões e regras de negócio antes de implementar persistência e operações reais.
