import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:acervovivo/main.dart';

void main() {
  setUp(() { SharedPreferences.setMockInitialValues({}); });

  testWidgets('AcervoVivo exige login ao iniciar', (tester) async {
    await tester.pumpWidget(const AcervoVivoApp());
    await tester.pumpAndSettle();

    expect(find.text('AcervoVivo'), findsOneWidget);
    expect(find.text('Entre para acessar sua biblioteca'), findsOneWidget);
    expect(find.text('Entrar'), findsOneWidget);
    expect(find.text('Catálogo de livros'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('login valida e-mail e senha antes de enviar', (tester) async {
    await tester.pumpWidget(const AcervoVivoApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Entrar'));
    await tester.pumpAndSettle();

    expect(find.text('Informe um e-mail válido.'), findsOneWidget);
    expect(find.text('Informe sua senha.'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
