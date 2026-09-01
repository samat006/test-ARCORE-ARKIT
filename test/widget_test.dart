import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:map_ar_app/main.dart';

void main() {
  testWidgets('Home screen shows the Carte button', (
    WidgetTester tester,
  ) async {
    // On enveloppe MapArApp dans un ProviderScope, comme dans main.dart,
    // sinon Riverpod plante (pas de contexte pour les providers).
    await tester.pumpWidget(const ProviderScope(child: MapArApp()));

    expect(find.text('Carte'), findsOneWidget);
  });
}
