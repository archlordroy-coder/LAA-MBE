import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laa_mbe/main.dart';

void main() {
  testWidgets('Dashboard and AI Pane load correctly', (WidgetTester tester) async {
    // Set a desktop-like surface size to avoid overflows
    tester.view.physicalSize = const Size(1920, 1080);
    tester.view.devicePixelRatio = 1.0;

    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    // Verify that Dashboard greeting is visible (Ghomala greeting)
    expect(find.text("Mbeu’n lɑ’ 👋"), findsOneWidget);

    // Verify that AI Assistant sidebar header is visible
    expect(find.text('LAA-MBÈ Assistant'), findsOneWidget);

    // Verify navigation rail icons exist (Dashboard icon)
    expect(find.byIcon(Icons.dashboard), findsOneWidget);
  });
}
