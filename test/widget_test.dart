// Smoke test for the Spark dating app.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:spark/main.dart';

void main() {
  testWidgets('Spark app boots to the Discover deck', (WidgetTester tester) async {
    await tester.pumpWidget(const SparkApp());

    // The brand title and the bottom navigation tabs should be present.
    expect(find.text('spark'), findsOneWidget);
    expect(find.text('Discover'), findsOneWidget);
    expect(find.text('Matches'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
  });
}
