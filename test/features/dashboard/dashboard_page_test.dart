import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/features/dashboard/presentation/pages/dashboard_page.dart';

void main() {
  testWidgets('DashboardPage displays greeting and briefing', (WidgetTester tester) async {
    // Build our app with a fixed size to avoid overflows in test environment
    tester.view.physicalSize = const Size(1200, 1000);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(const MaterialApp(home: DashboardPage()));

    // Verify that greeting is shown
    expect(find.textContaining('Bonjour Alex'), findsOneWidget);

    // Verify that Briefing IA card is present
    expect(find.text('Briefing IA'), findsOneWidget);

    addTearDown(tester.view.resetPhysicalSize);
  });
}
