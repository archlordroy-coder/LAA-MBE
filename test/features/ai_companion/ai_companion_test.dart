import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/features/ai_companion/presentation/widgets/ai_companion_sidebar.dart';
import 'package:app/features/ai_companion/presentation/providers/ai_provider.dart';

void main() {
  testWidgets('AICompanionSidebar sends message and receives response', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: Scaffold(body: AICompanionSidebar())),
      ),
    );

    // Initial message
    expect(find.textContaining('Bonjour Alex'), findsOneWidget);

    // Find TextField and send message
    final textField = find.byType(TextField);
    await tester.enterText(textField, 'Hello IA');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();

    // Verify user message is displayed
    expect(find.text('Hello IA'), findsOneWidget);

    // Wait for mock response
    await tester.pump(const Duration(seconds: 1));
    await tester.pump();

    // Verify AI response
    expect(find.textContaining('C\'est noté'), findsOneWidget);
  });
}
