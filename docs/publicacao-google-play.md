# Preparação para publicação na Google Play — AcervoVivo

**Plataforma:** Android  
**Data da revisão:** 19/11/2026  
**Situação:** preparação inicial; ainda não está pronto para publicação.

## 1. Objetivo

Preparar o projeto Flutter para, quando as funcionalidades estiverem concluídas e testadas, gerar uma versão Android publicável pela Google Play Store. O projeto não será preparado para iOS nesta etapa.

A publicação na loja é uma etapa posterior ao desenvolvimento. A versão atual ainda utiliza dados demonstrativos e não oferece cadastro persistente, login, empréstimos ou devoluções reais.

## 2. Estado atual

- [x] Flutter instalado no computador do estudante.
- [x] Primeira interface executada no Chrome.
- [x] Navegação inicial e filtros do catálogo conferidos pelo estudante.
- [x] Criado o script `scripts/preparar-android.ps1` para gerar a plataforma Android com o Flutter SDK local.
- [x] Definido nível-alvo de API 36 no script, conforme o requisito atual da Google Play para novos aplicativos móveis.
- [ ] Executar o script no computador e conferir a estrutura Android gerada.
- [ ] Instalar/configurar Android Studio e Android SDK Platform 36.
- [ ] Compilar e executar um APK de depuração em aparelho/emulador Android.
- [ ] Rever o layout e os fluxos em telas de celular.
- [ ] Substituir o ícone provisório do Flutter pela identidade visual definitiva do AcervoVivo.
- [ ] Definir e confirmar o Application ID antes de registrar o aplicativo na Play Console.
- [ ] Implementar backend, persistência, autenticação e funcionalidades essenciais.
- [ ] Criar política de privacidade e revisar a coleta/compartilhamento de dados.
- [ ] Criar chave de upload, configurar assinatura e gerar o Android App Bundle (.aab).
- [ ] Preencher conteúdo, classificação, público-alvo, Segurança dos dados, anúncios e demais declarações da Play Console.
- [ ] Fazer testes internos/fechados e atender às exigências de acesso à produção aplicáveis à conta.
- [ ] Enviar para análise e publicar após aprovação.

## 3. Identificador do aplicativo

O script usa como sugestão inicial:

`com.gabrielschmitt.acervovivo`

Esse valor é configurável ao executar o script. O identificador precisa ser confirmado antes da primeira publicação: depois que o aplicativo é publicado, mudar o Application ID faz a Google Play tratá-lo como outro aplicativo. A documentação do Android recomenda definir explicitamente o `applicationId` e mantê-lo igual ao `namespace`.

## 4. Preparar a estrutura Android no computador

Na pasta raiz do repositório, execute:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\preparar-android.ps1
```

Para usar outro identificador antes de publicar:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\preparar-android.ps1 -ApplicationId "br.com.suaorganizacao.acervovivo"
```

O script:
- gera a pasta Android com o Flutter instalado localmente, caso ela ainda não exista;
- configura `namespace` e `applicationId`;
- define `targetSdk = 36`, mantendo o `compileSdk` controlado pelo Flutter;
- define o nome exibido como AcervoVivo;
- declara a permissão de internet, necessária para a futura comunicação com o backend;
- adiciona regras para não versionar a chave de assinatura e o arquivo `key.properties`.

O script não instala Android Studio/SDK, não cria a chave de upload, não compila o app e não faz upload para a loja.

Depois de gerar a plataforma, valide com:

```powershell
cd app_flutter
flutter doctor -v
flutter doctor --android-licenses
flutter pub get
flutter build apk --debug
```

A construção requer Android SDK e licenças aceitas. Para testar em um dispositivo conectado, use `flutter devices` e depois `flutter run -d ID_DO_DISPOSITIVO`.

## 5. Identidade e pacote de lançamento

Antes de publicar, serão necessários:
- ícone do aplicativo nas dimensões e formatos exigidos pela Play Store e pelo Android;
- nome, descrição curta e descrição completa;
- capturas de tela reais do aplicativo em dispositivos compatíveis;
- versão do aplicativo e número de build crescentes a cada atualização;
- Application ID final;
- Android App Bundle (.aab) de lançamento, assinado com chave de upload.

O Flutter recomenda gerar o pacote de loja com:

```powershell
flutter build appbundle
```

O arquivo de saída esperado fica em:

`app_flutter/build/app/outputs/bundle/release/app.aab`

## 6. Assinatura e proteção das chaves

A primeira publicação na Google Play deve usar a Play App Signing. Será gerada uma chave de upload local, e o certificado público correspondente será enviado à Play Console quando solicitado. A chave privada e as senhas não devem ser adicionadas ao GitHub, compartilhadas em mensagens ou incluídas em arquivos de documentação.

O script ignora `key.properties`, `.jks` e `.keystore` na pasta Android, mas isso não substitui uma conferência de `git status` antes de qualquer commit.

Não criar a chave final até o Application ID ter sido confirmado e a publicação estar próxima.

## 7. Requisitos de conta e testes da Google Play

- A taxa de registro da conta Play Console é de US$ 25, paga uma única vez.
- Contas pessoais criadas depois de 13/11/2023 precisam, antes de solicitar acesso à produção, cumprir o teste fechado com pelo menos 12 testadores inscritos continuamente por 14 dias. A exigência depende do tipo e da data de criação da conta.
- A conta do desenvolvedor precisa fornecer as informações de identidade e contato solicitadas pelo Google.
- A Play Console exige metadados completos do aplicativo, declarações de conteúdo e classificação indicativa.
- Todos os aplicativos precisam de política de privacidade acessível e de uma declaração correta na seção Segurança dos dados, mesmo quando não coletam dados pessoais/sensíveis.
- Se houver criação de contas no aplicativo, a política de dados do Google Play exige meios de solicitar a exclusão da conta e dos dados associados, incluindo um caminho fora do aplicativo.

Os detalhes devem ser conferidos novamente na Play Console no momento do envio, pois a Google pode atualizar as políticas.

## 8. Impedimentos funcionais atuais

A versão presente ainda não deve ser publicada como versão final porque:
- livros e disponibilidade são demonstrativos;
- não há banco de dados ou API conectados;
- não existe login e controle real de perfis;
- cadastro, empréstimos, devoluções e histórico não são operações persistentes;
- não há uma política de privacidade baseada no fluxo real de dados.

A arquitetura de dados e sincronização está em discussão na Issue #7. A implementação do backend e das operações reais deverá ocorrer antes da versão pública.

## 9. Referências oficiais

- [Flutter — Build and release an Android app](https://docs.flutter.dev/deployment/android)
- [Google Play — Requisitos de nível da API](https://support.google.com/googleplay/android-developer/answer/11926878)
- [Google Play — Testes para novas contas pessoais](https://support.google.com/googleplay/android-developer/answer/14151465)
- [Android — Application ID e configuração do módulo](https://developer.android.com/build/configure-app-module)
- [Android — Assinatura de aplicativos](https://developer.android.com/studio/publish/app-signing)
- [Google Play — Preparar o app para análise](https://support.google.com/googleplay/android-developer/answer/9859455)
- [Google Play — Segurança dos dados e política de privacidade](https://support.google.com/googleplay/android-developer/answer/10144311)
