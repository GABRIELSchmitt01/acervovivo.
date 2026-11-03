# Protótipo e fluxos de navegação — AcervoVivo

**Projeto:** AcervoVivo — Sistema de Controle de Biblioteca  
**Curso:** Análise e Desenvolvimento de Sistemas — FASEC  
**Data:** 03/11/2026  
**Versão:** 0.1 — primeira rodada de prototipação  
**Situação:** protótipo visual editável; ainda não implementado em Flutter.

## 1. Objetivo desta etapa

Dar continuidade à primeira tela do AcervoVivo, organizando os principais caminhos de navegação e desenhando as telas necessárias para demonstrar como o usuário comum e o bibliotecário poderão utilizar o aplicativo. O protótipo considera bibliotecas em geral, com foco principal em escolas, faculdades e universidades, sem restringir o sistema a esses locais. As telas representam o controle de livros físicos, não a leitura ou o download de PDFs.

O protótipo serve como referência visual para as próximas etapas de implementação. Os elementos desenhados ainda não executam operações reais, não consultam banco de dados e não registram empréstimos.

## 2. Arquivos do Figma

- [Página 01 — Tela inicial do usuário comum](https://www.figma.com/design/eanAee98wCyRSHrNTa1q9C?node-id=2-30)
- [Página 02 — Fluxo e telas principais](https://www.figma.com/design/eanAee98wCyRSHrNTa1q9C?node-id=14-31)

A segunda página contém dois fluxos resumidos, nove telas complementares e uma pequena biblioteca de componentes reutilizáveis.

## 3. Fluxos representados

### 3.1 Usuário comum

1. Abre o aplicativo.
2. Acessa o catálogo.
3. Pesquisa um livro pelo título ou autor.
4. Consulta os detalhes e a disponibilidade.
5. Consulta o próprio histórico de empréstimos.

### 3.2 Bibliotecário

1. Acessa o painel administrativo.
2. Escolhe entre gerenciar livros ou usuários.
3. Registra um novo empréstimo.
4. Consulta os empréstimos em aberto.
5. Registra a devolução quando o livro retorna.

Os fluxos são uma representação inicial. A forma de identificação, autenticação e autorização ainda precisa ser confirmada antes da programação.

## 4. Telas desenhadas nesta etapa

| Tela | Finalidade | Observações |
|---|---|---|
| Seleção de perfil | Apresentar os dois tipos de uso previstos. | Conceitual; não define login nem permissões finais. |
| Catálogo | Exibir livros e filtros de pesquisa. | Dados demonstrativos. |
| Detalhes do livro | Apresentar informações e disponibilidade. | Quantidades reais ainda não estão conectadas. |
| Painel do bibliotecário | Reunir atalhos administrativos. | Indicadores aparecem sem números reais. |
| Cadastro de livro | Mostrar os campos propostos para uma obra. | Campos e obrigatoriedade precisam ser validados. |
| Cadastro de usuário | Mostrar os dados previstos para usuários. | Autenticação e permissões ainda não definidas. |
| Novo empréstimo | Associar usuário, livro e datas. | Prazo e limites ainda pendentes. |
| Empréstimos em aberto / devolução | Apresentar registros pendentes e ação de devolução. | Registros demonstrativos; não são empréstimos reais. |
| Histórico do usuário | Mostrar exemplos de empréstimos encerrados e em aberto. | O acesso deverá ser restrito ao usuário identificado. |

A tela inicial do usuário comum já havia sido desenhada anteriormente na Página 01 do mesmo arquivo.

## 5. Componentes reutilizáveis

Foram criados componentes editáveis para facilitar a consistência visual e evitar repetir elementos manualmente:

- **Field / AcervoVivo:** campo de formulário com rótulo e texto de orientação personalizáveis.
- **Button / Primary:** botão principal com texto personalizável.
- **BookRow / Catalog:** linha de catálogo com capa ilustrativa, título, autor e indicação de disponibilidade demonstrativa.

Os componentes podem ser reutilizados nas telas e ajustados conforme as regras finais forem aprovadas.

## 6. Dados e informações demonstrativas

Os nomes de livros e autores usados nas telas são exemplos para visualizar a interface. Os dados não representam um acervo real, usuários cadastrados ou movimentações realizadas em biblioteca.

Os indicadores administrativos aparecem sem valores reais porque ainda não existe banco de dados conectado ao protótipo.

A indicação de disponibilidade é apenas visual. A regra de cálculo deverá ser implementada e testada posteriormente.

## 7. Decisões ainda pendentes

O desenho das telas não resolve as seguintes definições:

- aprovação do uso de Flutter em relação ao Formulário 02 original;
- mecanismo de login, identificação dos perfis e permissões;
- armazenamento local ou sincronizado;
- campos obrigatórios do cadastro de usuários;
- prazo e limite de empréstimos, renovações e tratamento de atrasos;
- controle por quantidade de exemplares ou por cópia individual;
- inclusão ou não de reserva de livros na primeira versão.

As telas poderão ser ajustadas depois dessas decisões. Não se deve interpretar a presença de um campo ou botão no protótipo como uma regra aprovada.

## 8. Critérios para validar o protótipo

Antes de iniciar a implementação, recomenda-se revisar:

- se o caminho entre catálogo, detalhes e histórico está claro para o usuário comum;
- se o bibliotecário consegue localizar visualmente as operações administrativas;
- se os campos dos formulários correspondem à análise de requisitos;
- se as mensagens deixam claro quando os dados são apenas demonstrativos;
- se as telas respeitam os perfis e permissões que forem confirmados;
- se os fluxos contemplam os cenários previstos na especificação funcional.

## 9. Resultado desta etapa

Foi criada uma página complementar no Figma com nove telas editáveis, dois fluxos de navegação e três componentes reutilizáveis. O protótipo complementa a tela inicial anterior e oferece uma visão mais ampla da primeira versão do AcervoVivo.

Esta etapa conclui uma primeira rodada de prototipação visual. Ela não significa que o aplicativo esteja programado, que os fluxos estejam funcionando ou que as decisões pendentes tenham sido aprovadas.

## 10. Próxima etapa recomendada

Revisar os protótipos junto com a especificação funcional, resolver as decisões de escopo e tecnologia e confirmar a adequação do Flutter ao plano de estágio. Depois da validação, será possível criar o projeto Flutter e iniciar a implementação de forma alinhada à documentação.
