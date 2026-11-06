import 'package:flutter_test/flutter_test.dart';
import 'package:sikka/app.dart';

void main() {
  testWidgets('SikkaApp builds without crashes', (WidgetTester tester) async {
    await tester.pumpWidget(const SikkaApp());
    expect(find.byType(SikkaApp), findsOneWidget);
  });
}
