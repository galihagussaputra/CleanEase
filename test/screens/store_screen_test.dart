import 'package:clean_ease/features/shop/screens/store/store.dart';
import 'package:clean_ease/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('store screen builds with matching tabs on a compact screen',
      (tester) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.lightTheme, home: const StoreScreen()),
    );
    await tester.pump(const Duration(milliseconds: 300));

    expect(tester.takeException(), isNull);
    expect(find.text('Cleaning'), findsOneWidget);
    expect(find.text('Pest Control'), findsOneWidget);
    expect(find.text('Laundry'), findsOneWidget);
    expect(find.text('Electrician'), findsOneWidget);
  });
}
