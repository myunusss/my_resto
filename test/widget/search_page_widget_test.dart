import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_resto/screens/search_page.dart';

void main() {
  MaterialApp app = MaterialApp(
    home: Scaffold(
      body: SearchPage(),
    ),
  );
  testWidgets(
      "Should contain Flexible widget as Parent of List and TextFormField to find restaurant",
      (WidgetTester tester) async {
    await tester.pumpWidget(app);

    expect(find.byType(Flexible), findsOneWidget);
    expect(find.byType(TextFormField), findsOneWidget);
  });
}
