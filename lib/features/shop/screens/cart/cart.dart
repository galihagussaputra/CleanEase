import 'package:clean_ease/common/widgets/appbar/appbar.dart';
import 'package:clean_ease/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:clean_ease/features/shop/screens/checkout/checkout.dart';
import 'package:clean_ease/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppsBar(
          showBackArrow: true,
          title:
              Text('Cart', style: Theme.of(context).textTheme.headlineSmall)),
      body: const Padding(
        padding: EdgeInsets.all(AppSize.defaultSpace),
        child: AppCartItems(),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(AppSize.defaultSpace),
        child: ElevatedButton(
            onPressed: () => Get.to(() => const CheckoutScreen()),
            child: const Text('Checkout Rp 295.0')),
      ),
    );
  }
}
