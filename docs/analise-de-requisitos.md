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

Este documento apresenta a análise inicial dos requisitos do AcervoVivo, um projeto de sistema destinado a auxiliar no gerenciamento das informações de uma biblioteca. A proposta busca organizar os dados dos livros e dos usuários, além de facilitar o registro e o acompanhamento dos empréstimos e das devoluções.

A análise de requisitos servirá como base para o planejamento, a modelagem do banco de dados, o desenvolvimento e os testes do produto computacional.

## 2. Problema identificado

A organização dos livros, dos usuários e dos empréstimos pode se tornar difícil quando as informações não estão centralizadas em um sistema. Essa situação pode dificultar a consulta aos dados e o acompanhamento dos livros emprestados e devolvidos.

Diante desse problema, propõe-se desenvolver um sistema que reúna essas informações em um único ambiente, facilitando as atividades de gerenciamento da biblioteca.

## 3. Objetivo geral

Desenvolver um sistema de controle de biblioteca que facilite o gerenciamento dos livros, dos usuários, dos empréstimos e das devoluções, mantendo as informações organizadas em um banco de dados.

## 4. Objetivos específicos

- Permitir o cadastro, a consulta, a alteração e a exclusão de livros.
- Permitir o cadastro e a consulta de usuários.
- Registrar os empréstimos e as devoluções de livros.
- Organizar as informações em um banco de dados.
- Disponibilizar uma interface simples e adequada à utilização do sistema.
- Realizar testes das principais funcionalidades e corrigir problemas identificados.

## 5. Escopo do sistema

A proposta inicial contempla o gerenciamento dos livros e dos usuários, o registro dos empréstimos e das devoluções e a consulta às informações cadastradas.

O sistema deverá considerar dois perfis de utilização: bibliotecário e usuário comum. As permissões específicas de cada perfil serão detalhadas durante a especificação dos requisitos.

O escopo poderá ser ajustado conforme as orientações do professor orientador e a validação da proposta de projeto.

## 6. Usuários do sistema

### 6.1 Bibliotecário

O bibliotecário será responsável pelo gerenciamento dos livros, dos usuários e dos registros de empréstimos e devoluções.

As operações previstas para esse perfil incluem cadastrar, consultar, alterar e excluir livros, além de cadastrar e consultar usuários e registrar empréstimos e devoluções.

### 6.2 Usuário comum

O usuário comum poderá consultar os livros cadastrados e visualizar seu próprio histórico de empréstimos.

O acesso ao histórico deverá respeitar as permissões definidas para esse perfil.

### 6.3 Cadastro de usuários

A proposta inicial estabelece que o cadastro de novos usuários será realizado somente pelo bibliotecário.

O mecanismo de identificação dos usuários e o controle de acesso aos recursos serão definidos durante o detalhamento da solução.

## 7. Requisitos funcionais

Os requisitos funcionais descrevem as operações que o sistema deverá disponibilizar.

**RF01 — Cadastro de livros:** o sistema deverá permitir o cadastro de livros.

**RF02 — Consulta de livros:** o sistema deverá permitir a consulta aos livros cadastrados.

**RF03 — Alteração de livros:** o sistema deverá permitir a atualização dos dados de livros existentes.

**RF04 — Exclusão de livros:** o sistema deverá permitir a exclusão de livros, respeitando as regras de integridade que forem definidas.

**RF05 — Cadastro de usuários:** o sistema deverá permitir que o bibliotecário cadastre novos usuários.

**RF06 — Consulta de usuários:** o sistema deverá permitir que o bibliotecário consulte os usuários cadastrados.

**RF07 — Registro de empréstimos:** o sistema deverá permitir o registro de empréstimos, associando o livro, o usuário e as datas correspondentes.

**RF08 — Registro de devoluções:** o sistema deverá permitir o registro das devoluções dos livros emprestados.

**RF09 — Gerenciamento pelo bibliotecário:** o sistema deverá disponibilizar ao bibliotecário as operações administrativas previstas para livros, usuários, empréstimos e devoluções.

**RF10 — Consulta pelo usuário comum:** o sistema deverá permitir que o usuário comum consulte os livros e seu próprio histórico de empréstimos.

**RF11 — Restrição do cadastro:** o sistema deverá restringir o cadastro de novos usuários ao perfil de bibliotecário.

Os requisitos RF01 a RF08 detalham funcionalidades previstas no Plano de Atividades. Os requisitos RF09 a RF11 representam decisões preliminares de detalhamento do projeto e deverão ser revisados durante a definição das permissões e das regras de acesso.

## 8. Dados do cadastro de livros

O cadastro de livros terá como finalidade armazenar as informações necessárias à identificação e à organização das obras da biblioteca.

| Campo | Descrição |
|---|---|
| Título do livro | Nome da obra. |
| Autor | Nome do autor ou dos autores. |
| ISBN | Identificador associado à edição publicada. |
| Categoria ou gênero | Classificação temática ou literária. |
| Ano de publicação | Ano de publicação da edição. |
| Quantidade de exemplares | Número de exemplares registrados para a obra. |
| Editora | Nome da editora responsável pela publicação. |
| Descrição ou sinopse | Resumo ou apresentação do conteúdo. |

Esses campos constituem uma proposta inicial do projeto. A obrigatoriedade de preenchimento e as regras de validação ainda serão definidas.

## 9. Dados dos empréstimos e das devoluções

O registro de empréstimos deverá associar o livro ao usuário responsável e armazenar as datas necessárias ao acompanhamento da operação.

Inicialmente, deverão ser considerados:

- Identificação do livro.
- Identificação do usuário.
- Data do empréstimo.
- Data prevista para devolução, caso seja adotada essa regra.
- Data efetiva da devolução, quando registrada.

A definição final dos campos dependerá das regras de negócio estabelecidas para o sistema.

Também deverá ser avaliada a relação entre a quantidade de exemplares cadastrados e os exemplares disponíveis para empréstimo, evitando inconsistências no controle da biblioteca.

## 10. Requisitos não funcionais e características gerais

**RNF01 — Organização dos dados:** as informações deverão ser organizadas em um banco de dados.

**RNF02 — Interface:** a interface deverá ser simples e adequada à utilização das funcionalidades previstas.

**RNF03 — Responsividade:** deverá ser considerada a adaptação da interface aos diferentes tamanhos de tela, conforme a plataforma definida para o projeto.

**RNF04 — Integridade das informações:** deverão ser consideradas regras para evitar inconsistências nos cadastros e nos registros de empréstimos e devoluções.

**RNF05 — Testes:** as principais funcionalidades deverão ser testadas, e os problemas identificados deverão ser corrigidos.

Os requisitos RNF01, RNF02 e RNF05 estão alinhados às características descritas no Plano de Atividades. Os demais detalham aspectos a serem considerados no desenvolvimento.

## 11. Regras de negócio a definir

As seguintes regras ainda precisam ser especificadas:

- Quais campos do cadastro de livros serão obrigatórios.
- Como serão validados o ISBN, o ano de publicação e a quantidade de exemplares.
- Como serão tratados livros com exemplares emprestados no momento de uma tentativa de exclusão.
- Como será controlada a disponibilidade dos exemplares.
- Quais serão os prazos e as condições de empréstimo e devolução.
- Como serão identificados os usuários e aplicadas as permissões de acesso.
- Como será garantido que o usuário comum visualize somente o próprio histórico.

Essas regras constituem pontos de análise que deverão ser definidos conforme o escopo do sistema, e não exigências já aprovadas pela faculdade.

## 12. Tecnologias e arquitetura

O Plano de Atividades da proposta aprovada descreve um sistema web e prevê o uso de FastAPI e SQLAlchemy no desenvolvimento do backend.

A possibilidade de desenvolver a interface como aplicativo Flutter ainda precisa ser confirmada com o professor orientador. Até essa confirmação, a arquitetura definitiva e a escolha final da plataforma permanecem pendentes.

## 13. Pendências para validação

- Confirmar com o professor orientador se a proposta de interface em Flutter é compatível com o projeto aprovado.
- Validar o escopo e os perfis de utilização.
- Definir as regras de negócio para empréstimos e devoluções.
- Definir as regras de validação dos cadastros.
- Detalhar o mecanismo de autenticação e as permissões de acesso.
- Atualizar a documentação caso sejam necessárias alterações relevantes no planejamento.

## 14. Resultados esperados

Espera-se que o projeto resulte em um sistema funcional para o gerenciamento de livros, usuários, empréstimos e devoluções, com informações organizadas em banco de dados e uma interface adequada à plataforma aprovada.

A conclusão do produto dependerá da implementação e dos testes das funcionalidades previstas, além da documentação e dos registros exigidos para o estágio.

## 15. Considerações finais

Esta análise de requisitos constitui uma versão inicial do planejamento do AcervoVivo. O documento deverá ser atualizado à medida que as regras de negócio forem definidas, as decisões técnicas forem validadas e o sistema for desenvolvido.

As funcionalidades e os campos apresentados refletem o Plano de Atividades e as decisões preliminares do projeto. Alterações relevantes deverão ser alinhadas com o professor orientador, conforme as orientações da disciplina de Estágio Supervisionado Obrigatório.
