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

Neste momento, a proposta é desenvolver **um aplicativo em Flutter** para auxiliar no controle de uma biblioteca.

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
| Flutter | Construir a interface do aplicativo. | Escolhida como foco atual. |
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

Deverá poder consultar os livros e o próprio histórico de empréstimos.

A forma como o aplicativo identificará cada perfil, fará o login e protegerá o histórico ainda precisa ser especificada. Não será implementado um mecanismo de autenticação antes de definir essa parte.

## 5. Telas que poderão fazer parte da primeira versão

A lista abaixo é uma proposta inicial para organizar o desenho das telas. A quantidade e o conteúdo poderão mudar durante a prototipação.

1. **Tela de acesso ou identificação:** entrada no aplicativo e identificação do perfil, conforme a solução que for definida.
2. **Tela inicial:** atalhos para as principais funções disponíveis ao perfil.
3. **Consulta de livros:** lista e busca dos livros cadastrados.
4. **Cadastro e edição de livros:** formulário com os campos definidos na análise de requisitos.
5. **Consulta e cadastro de usuários:** funções administrativas do bibliotecário.
6. **Registro de empréstimo:** seleção do usuário e do livro e registro das datas.
7. **Devolução de livro:** localização de um empréstimo em aberto e registro da devolução.
8. **Histórico de empréstimos:** consulta ao histórico do próprio usuário e, se necessário, visualização administrativa pelo bibliotecário.

Estas telas são sugestões para o planejamento; não significa que o protótipo já esteja feito ou que o professor tenha exigido o uso do Figma.

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
4. Desenhar o fluxo de navegação e os primeiros wireframes das telas.
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
- Definir se o Figma ou outra ferramenta de prototipação será necessária.
- Confirmar com o professor a diferença entre a proposta atual em Flutter e o sistema web descrito no Formulário 02.

## 10. Próxima atividade

A próxima atividade de trabalho será desenhar o fluxo de navegação e esboçar as telas principais do aplicativo. Esse desenho ajudará a conferir se o caminho entre as funções está claro antes de começar a montar as telas em Flutter.
