import 'package:flutter_test/flutter_test.dart';

import 'package:acervovivo/main.dart';

void main() {
  testWidgets('AcervoVivo abre na tela inicial', (tester) async {
    await tester.pumpWidget(const AcervoVivoApp());

    expect(find.text('AcervoVivo'), findsOneWidget);
    expect(find.text('Sua próxima leitura\ncomeça aqui.'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('navega da tela inicial para o catálogo', (tester) async {
    await tester.pumpWidget(const AcervoVivoApp());

    await tester.tap(find.text('Catálogo'));
    await tester.pumpAndSettle();

    expect(find.text('Catálogo de livros'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
