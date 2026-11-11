# Validação local da base Flutter — AcervoVivo

Este roteiro serve para validar a primeira versão do aplicativo no computador de desenvolvimento. Ele **não afirma que o aplicativo já foi executado**: os comandos abaixo precisam ser rodados localmente e os resultados devem ser registrados depois.

## 1. Atualizar a cópia local do repositório

Abra o PowerShell ou o terminal do VS Code na pasta local do repositório.

Primeiro, verifique se há alterações locais ainda não salvas:

```powershell
git status
```

Se houver arquivos modificados que você deseja manter, faça commit ou backup antes de atualizar. Depois, atualize a branch principal:

```powershell
git pull origin main
```

Entre na pasta Flutter:

```powershell
cd app_flutter
```

Confirme que esta pasta contém o arquivo `pubspec.yaml`:

```powershell
dir
```

## 2. Conferir o Flutter instalado

Execute:

```powershell
flutter --version
flutter doctor -v
```

O primeiro comando informa as versões do Flutter e do Dart. O segundo verifica as ferramentas disponíveis e aponta o que falta para cada plataforma.

- Se `flutter` não for reconhecido, o SDK não está instalado corretamente ou não está no PATH. Consulte o [guia oficial de instalação do Flutter](https://docs.flutter.dev/install).
- Para executar como aplicativo Windows, instale o Visual Studio (não apenas o VS Code) com a carga de trabalho **Desenvolvimento para desktop com C++**. Consulte [Configurar desenvolvimento Windows no Flutter](https://docs.flutter.dev/platform-integration/windows/setup).
- Avisos relacionados a plataformas que não serão usadas agora podem ser deixados para depois. Concentre-se na plataforma que será testada.

## 3. Gerar os arquivos das plataformas

Ainda dentro de `app_flutter`, execute:

```powershell
flutter create --platforms=android,windows --project-name acervovivo .
```

Esse comando gera a estrutura nativa necessária para Android e Windows no projeto existente. Não substitua manualmente os arquivos de `lib/`.

## 4. Baixar dependências

```powershell
flutter pub get
```

Resultado esperado: conclusão da resolução de dependências sem erro.

## 5. Analisar o código e executar os testes

```powershell
flutter analyze
flutter test
```

O analisador deve terminar sem erros que impeçam a compilação. Os testes de widget preparados no projeto verificam a inicialização do aplicativo e a navegação até o catálogo. Se algum teste falhar, copie a mensagem completa para análise; não marque a etapa como concluída ainda.

## 6. Verificar dispositivos e executar

```powershell
flutter devices
```

Para executar no Windows:

```powershell
flutter run -d windows
```

Se for testar no Android, conecte o aparelho com depuração USB ativada ou inicie um emulador e use o identificador exibido por `flutter devices`:

```powershell
flutter run -d ID_DO_DISPOSITIVO
```

## 7. O que conferir na primeira abertura

- [ ] O aplicativo abre sem encerrar inesperadamente.
- [ ] A tela inicial aparece.
- [ ] A navegação inferior troca entre Início, Catálogo, Histórico e Perfil.
- [ ] A pesquisa encontra livros de demonstração por título ou autor.
- [ ] Os filtros de categoria alteram os resultados.
- [ ] Ao tocar em um livro, os detalhes demonstrativos são exibidos.
- [ ] Não há texto cortado ou elementos sobrepostos no tamanho de tela testado.

## 8. Registrar o resultado

Depois de executar, anote em uma Issue ou no registro de atividade:

- Sistema operacional e plataforma testada (Windows ou Android).
- Versões mostradas por `flutter --version`.
- Resultado de `flutter doctor -v` (somente os itens relevantes; oculte caminhos ou dados pessoais se compartilhar capturas).
- Resultado de `flutter analyze`.
- Resultado de `flutter test`.
- Se `flutter run` abriu o aplicativo.
- Problemas encontrados e como foram corrigidos.

Não registre horas estimadas como horas realizadas. Informe apenas o tempo que efetivamente foi dedicado à atividade.

## Limites conhecidos desta versão

A base atual usa livros fictícios/de demonstração. Ainda não há banco de dados, login real, sincronização, cadastro persistente de livros e usuários, empréstimos ou devoluções funcionais. A definição da arquitetura de armazenamento depende da Issue #7, e a confirmação formal da tecnologia em relação ao Formulário 02 depende da Issue #1.

**Próximo passo após esta validação:** avançar para a [Issue #19 — implementar no Flutter as telas do protótipo Figma](https://github.com/GABRIELSchmitt01/acervovivo./issues/19), respeitando as decisões pendentes.
