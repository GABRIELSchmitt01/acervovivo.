# Registro de decisão — autorização para uso de Flutter

**Projeto:** AcervoVivo — Sistema de Controle de Biblioteca  
**Curso:** Análise e Desenvolvimento de Sistemas — FASEC  
**Data do registro:** 13/11/2026  
**Origem da informação:** confirmação comunicada pelo estudante após conversa com o professor orientador.

## 1. Decisão registrada

O estudante informou que conversou com o professor orientador e recebeu autorização para atualizar a proposta do produto computacional e desenvolver o AcervoVivo utilizando **Flutter**.

Com isso, o Flutter passa a ser a tecnologia aprovada para a construção da aplicação, substituindo a pendência de confirmação que existia em relação à proposta de sistema web descrita originalmente no Formulário 02.

Este registro documenta a orientação conforme relatada pelo estudante. Não é uma transcrição de mensagem, ata ou documento emitido pelo professor.

## 2. Consequências para o planejamento

- A interface e a aplicação serão desenvolvidas em Flutter com a linguagem Dart.
- O protótipo do Figma e a base Flutter já criada continuam válidos como ponto de partida.
- A proposta de desenvolver uma interface web separada deixa de ser o foco da primeira versão.
- A decisão sobre banco de dados, API/backend e sincronização entre dispositivos continua em aberto e será tratada separadamente na Issue #7.
- A aprovação de Flutter não define automaticamente autenticação, perfis, permissões, regras de empréstimo ou modelo de exemplares.

## 3. Próxima decisão técnica

Antes de implementar persistência, será necessário decidir como bibliotecário e usuários consultarão os mesmos dados em dispositivos diferentes. Um banco local isolado em um único aparelho não sincroniza os dados automaticamente com os demais.

A comparação das alternativas e a escolha do armazenamento serão registradas na Issue #7 e nos documentos de arquitetura/modelagem.

## 4. Atualização documental

Este registro fundamenta a atualização do README, do planejamento, da análise de requisitos, da especificação funcional e do Kanban em 13/11/2026.

