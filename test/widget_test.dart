import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wassaly_mohamed_aboud/main.dart';

void main() {
  testWidgets('shows customer app home', (tester) async {
    await tester.pumpWidget(const WassalyApp());
    expect(find.text('وصلني'), findsOneWidget);
    expect(find.text('ماذا تحتاج؟'), findsOneWidget);
  });
}
