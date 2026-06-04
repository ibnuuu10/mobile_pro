import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:anak_pintar/main.dart';

void main() {
  testWidgets('Anak Pintar smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const AnakPintarApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
