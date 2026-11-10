import 'package:clean_ease/common/widgets/images/app_rounded_image.dart';
import 'package:clean_ease/common/widgets/layouts/grid_layout.dart';
import 'package:clean_ease/common/widgets/products/cart/cart_item.dart';
import 'package:clean_ease/common/widgets/products/product_card/product_card_vertical.dart';
import 'package:clean_ease/common/widgets/texts/section_heading.dart';
import 'package:clean_ease/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:clean_ease/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> pumpAt(
  WidgetTester tester,
  Widget child, {
  Size size = const Size(320, 640),
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.lightTheme,
      home: Scaffold(body: child),
    ),
  );
  await tester.pump();
}

void main() {
  testWidgets('section heading does not overflow on narrow screens',
      (tester) async {
    await pumpAt(
      tester,
      const Padding(
        padding: EdgeInsets.all(24),
        child: AppSectionHeading(
          title: 'Popular Services and Home Cleaning Offers',
          onPressed: _noop,
        ),
      ),
    );

    expect(tester.takeException(), isNull);
    expect(find.text('Popular Services and Home Cleaning Offers'), findsOneWidget);
  });

  testWidgets('product grid fits a compact screen', (tester) async {
    await pumpAt(
      tester,
      SingleChildScrollView(
        child: AppGridLayout(
          itemCount: 2,
          itemBuilder: (_, __) => const AppProductCardVertical(),
        ),
      ),
    );

    expect(tester.takeException(), isNull);
    expect(find.byType(AppProductCardVertical), findsNWidgets(2));
  });

  testWidgets('cart item fits a compact screen', (tester) async {
    await pumpAt(
      tester,
      const Padding(
        padding: EdgeInsets.all(24),
        child: AppCartItem(),
      ),
    );

    expect(tester.takeException(), isNull);
    expect(find.text('Nike'), findsOneWidget);
  });

  testWidgets('payment section renders the PayPal asset', (tester) async {
    await pumpAt(
      tester,
      const Padding(
        padding: EdgeInsets.all(24),
        child: AppBillingPaymentSection(),
      ),
    );
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.text('Paypal'), findsOneWidget);
  });

  testWidgets('rounded image shows a placeholder for an empty URL',
      (tester) async {
    await pumpAt(
      tester,
      const AppRoundedImage(imageUrl: '', width: 100, height: 100),
    );

    expect(tester.takeException(), isNull);
    expect(find.byIcon(Icons.image_not_supported_outlined), findsOneWidget);
  });
}

void _noop() {}
