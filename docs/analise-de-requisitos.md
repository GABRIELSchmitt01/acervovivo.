# Análise de Requisitos
## AcervoVivo — Sistema de Controle de Biblioteca

**Instituição:** FASEC — Faculdade Serra do Carmo  
**Curso:** Análise e Desenvolvimento de Sistemas  
**Disciplina:** Estágio Supervisionado Obrigatório  
**Modalidade:** Projeto + Produto Computacional  
**Estudante:** Gabriel Schmitt Maciel  
**Professor orientador:** Prof. Lucas Dias  
**Data da versão:** 20/10/2026

## 1. Introdução

Este documento reúne os requisitos iniciais do AcervoVivo, um projeto pensado para ajudar na organização de uma biblioteca. A ideia é ter um lugar onde seja possível consultar os livros, manter os dados dos usuários e registrar empréstimos e devoluções.

Este levantamento será usado como ponto de partida para planejar o sistema, organizar o banco de dados, desenvolver as funcionalidades e testar o que for criado.

## 2. Problema identificado

Controlar livros, usuários e empréstimos pode ser difícil quando as informações ficam espalhadas ou não estão bem organizadas. Isso pode deixar mais demorada a consulta aos dados e dificultar o acompanhamento dos livros que foram emprestados ou devolvidos.

Por esse motivo, a proposta é criar um sistema que reúna essas informações e facilite o trabalho de gerenciamento da biblioteca.

## 3. Objetivo geral

Desenvolver um sistema para organizar os livros e os usuários de uma biblioteca e registrar os empréstimos e as devoluções em um banco de dados.

## 4. Objetivos específicos

- Cadastrar, consultar, alterar e excluir livros.
- Cadastrar e consultar usuários.
- Registrar empréstimos e devoluções.
- Manter as informações organizadas em um banco de dados.
- Criar uma interface simples, adequada ao uso do sistema.
- Testar as principais funcionalidades e corrigir os problemas encontrados.

## 5. Escopo do sistema

Na primeira versão, o sistema deverá permitir o gerenciamento dos livros e dos usuários, além do registro de empréstimos e devoluções e da consulta às informações cadastradas.

A proposta considera dois tipos de usuários: bibliotecário e usuário comum. O bibliotecário ficará responsável pelas operações de gerenciamento. O usuário comum poderá consultar os livros e visualizar o próprio histórico de empréstimos.

As permissões e algumas regras de funcionamento ainda precisam ser detalhadas. O escopo também poderá ser ajustado conforme as orientações do professor orientador e a validação do projeto.

## 6. Usuários do sistema

### 6.1 Bibliotecário

O bibliotecário será responsável por administrar os livros, os usuários e os registros de empréstimos e devoluções. A proposta inicial é que ele possa cadastrar, consultar, alterar e excluir livros, além de cadastrar e consultar usuários e registrar empréstimos e devoluções.

### 6.2 Usuário comum

O usuário comum poderá consultar os livros cadastrados e visualizar seu próprio histórico de empréstimos. O sistema deverá limitar essa consulta aos dados do próprio usuário.

### 6.3 Cadastro de usuários

Na proposta inicial, somente o bibliotecário poderá cadastrar novos usuários. A forma de identificar cada pessoa e controlar o acesso às funções será definida durante o desenvolvimento.

### 6.4 Campos propostos para o cadastro de usuários

Para começar a modelar o cadastro, foram listados estes campos como sugestão:

| Campo | Finalidade | Situação |
|---|---|---|
| Nome completo | Identificar a pessoa cadastrada. | Proposto |
| E-mail | Guardar um contato e avaliar seu uso na identificação do usuário. | Proposto |
| Telefone | Ter um contato adicional, caso seja necessário. | Proposto; confirmar se será usado |
| Código ou matrícula da biblioteca | Diferenciar os usuários por um código interno, se for útil. | Proposto; confirmar necessidade |
| Situação do cadastro | Indicar se o cadastro está ativo ou inativo. | Proposto; confirmar necessidade |

Esta lista não é uma exigência definida pela FASEC. Também ainda não foi decidido quais campos serão obrigatórios, como serão validados e quais serão realmente usados na versão inicial do sistema.

## 7. Requisitos funcionais

Os requisitos funcionais descrevem as ações que o sistema deverá permitir.

- **RF01 — Cadastrar livros:** permitir o cadastro de livros.
- **RF02 — Consultar livros:** permitir a consulta aos livros cadastrados.
- **RF03 — Alterar livros:** permitir a atualização dos dados de um livro.
- **RF04 — Excluir livros:** permitir a exclusão de livros, respeitando as regras de integridade que forem definidas.
- **RF05 — Cadastrar usuários:** permitir que o bibliotecário cadastre novos usuários.
- **RF06 — Consultar usuários:** permitir que o bibliotecário consulte os usuários cadastrados.
- **RF07 — Registrar empréstimos:** permitir o registro de um empréstimo, relacionando o livro, o usuário e as datas correspondentes.
- **RF08 — Registrar devoluções:** permitir o registro da devolução de um livro emprestado.
- **RF09 — Gerenciamento pelo bibliotecário:** disponibilizar ao bibliotecário as funções de gerenciamento de livros, usuários, empréstimos e devoluções.
- **RF10 — Consulta pelo usuário comum:** permitir que o usuário comum consulte os livros e seu próprio histórico de empréstimos.
- **RF11 — Limitar o cadastro de usuários:** permitir o cadastro de novos usuários somente ao bibliotecário.
- **RF12 — Restringir o acesso ao histórico:** antes de mostrar um histórico pessoal, o sistema deverá identificar o usuário e limitar a consulta aos empréstimos associados a ele. A forma de identificação ainda precisa ser escolhida.

Os requisitos RF01 a RF08 detalham funcionalidades que aparecem no Plano de Atividades. Os requisitos RF09 a RF12 detalham decisões iniciais do projeto e precisam ser revistos junto com as regras de acesso.

## 8. Dados do cadastro de livros

O cadastro de livros deverá guardar informações que ajudem a identificar e organizar as obras. Para a primeira versão, foram propostos os seguintes campos:

| Campo | Para que serve |
|---|---|
| Título do livro | Informar o nome da obra. |
| Autor | Informar o nome do autor ou dos autores. |
| ISBN | Registrar o identificador da edição publicada, quando houver. |
| Categoria ou gênero | Classificar o livro por assunto ou gênero literário. |
| Ano de publicação | Informar o ano em que a edição foi publicada. |
| Quantidade de exemplares | Registrar quantos exemplares da obra a biblioteca possui. |
| Editora | Informar a editora responsável pela publicação. |
| Descrição ou sinopse | Apresentar um resumo do conteúdo do livro. |

Esses campos são uma proposta inicial do projeto, não uma lista de campos exigida diretamente pela faculdade. Ainda será necessário definir quais serão obrigatórios e quais validações serão aplicadas.

## 9. Dados dos empréstimos e das devoluções

Para registrar um empréstimo, será necessário relacionar o livro ao usuário e guardar as datas importantes. A proposta inicial considera:

- Identificação do livro.
- Identificação do usuário.
- Data do empréstimo.
- Data prevista para a devolução, se essa regra for adotada.
- Data em que a devolução foi realizada.

A lista final de campos dependerá das regras definidas para o sistema. Também será necessário controlar a quantidade de exemplares disponíveis, já que alguns livros poderão estar emprestados.

## 10. Regras de negócio propostas

As regras abaixo são sugestões para tornar o sistema coerente. Ainda precisam ser confirmadas e ajustadas antes da implementação.

- **RB01 — Responsável pelos registros:** na proposta inicial, o bibliotecário registra os empréstimos e as devoluções.
- **RB02 — Disponibilidade:** o sistema não deverá permitir um empréstimo quando não houver exemplar disponível.
- **RB03 — Dados do empréstimo:** cada empréstimo deverá estar associado a um livro, a um usuário e à data em que ocorreu.
- **RB04 — Prazo:** caso seja adotada uma data prevista de devolução, o prazo deverá ser definido antes de implementar a regra.
- **RB05 — Devolução:** ao registrar uma devolução, o sistema deverá guardar a data efetiva e atualizar a disponibilidade do livro.
- **RB06 — Histórico pessoal:** o usuário comum poderá consultar apenas o próprio histórico de empréstimos.
- **RB07 — Exclusão de livros:** precisamos decidir como tratar a tentativa de excluir um livro que tenha empréstimos em andamento. Uma opção é bloquear a exclusão até que esses empréstimos sejam encerrados.

Ainda não foram definidos o prazo de empréstimo, o limite de livros por usuário, as renovações ou as consequências de uma devolução atrasada. Não vamos criar esses limites sem antes decidir se farão parte do projeto.

## 11. Requisitos não funcionais e características gerais

Além das funções do sistema, também precisamos considerar alguns aspectos de organização e uso:

- **RNF01 — Organização dos dados:** as informações deverão ficar organizadas em um banco de dados.
- **RNF02 — Interface:** a interface deverá ser simples e fácil de entender.
- **RNF03 — Adaptação da interface:** deverá ser avaliada a adaptação da interface aos diferentes tamanhos de tela, de acordo com a plataforma aprovada para o projeto.
- **RNF04 — Integridade das informações:** deverão ser definidas regras para evitar dados inconsistentes nos cadastros e nos registros de empréstimos e devoluções.
- **RNF05 — Testes:** as principais funções deverão ser testadas, e os problemas encontrados deverão ser corrigidos.

A organização dos dados, a simplicidade da interface e a realização de testes estão de acordo com o Plano de Atividades. Os demais pontos são aspectos que serão considerados durante o desenvolvimento.

## 12. Tecnologia e arquitetura

A proposta atual do produto é desenvolver um aplicativo em Flutter. Uma versão web não faz parte do escopo neste momento; é apenas uma possibilidade futura, ainda sem confirmação.

Existe uma diferença entre essa proposta e o Formulário 02 da FASEC, que descreve um sistema web e prevê o uso de FastAPI e SQLAlchemy no backend. Essa diferença precisa ser conversada com o professor orientador, para confirmar se a proposta Flutter pode ser usada ou se será necessário ajustar o plano aprovado.

Por enquanto, o planejamento do produto ficará voltado ao aplicativo Flutter. Não está previsto iniciar uma API ou desenvolver uma versão web nesta etapa.

## 13. Pontos para confirmar e validar

Antes de avançar para a implementação, será necessário:

- Confirmar com o professor se o aplicativo Flutter pode substituir o sistema web descrito no Formulário 02, ou se o plano precisará ser ajustado.
- Revisar os perfis de usuário e as permissões de cada um.
- Confirmar quais campos serão usados no cadastro de usuários e quais serão obrigatórios.
- Decidir como os usuários serão identificados para acessar o próprio histórico.
- Definir o prazo e as condições de empréstimo e devolução.
- Decidir como tratar a exclusão de livros que tenham empréstimos em andamento.
- Decidir as validações dos cadastros.
- Atualizar este documento caso o plano precise de mudanças.

## 14. Resultado esperado

Ao final do projeto, espera-se ter um sistema que ajude a organizar os livros e os usuários da biblioteca e que permita registrar empréstimos e devoluções. As informações deverão estar organizadas em um banco de dados e a interface deverá ser adequada à plataforma aprovada.

Para considerar o produto concluído, será necessário desenvolver e testar as funcionalidades previstas, além de manter a documentação e os registros solicitados para o estágio.
