import 'package:clean_ease/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class AppBillingAmountSection extends StatelessWidget {
  const AppBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // subtotal
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Subtotal', style: Theme.of(context).textTheme.bodyMedium),
            Text('Rp 245', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: AppSize.spaceBtwItems / 2),

        // Shipping fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Shipping Fee', style: Theme.of(context).textTheme.bodyMedium),
            Text('Rp 25', style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        const SizedBox(height: AppSize.spaceBtwItems / 2),

        // Tax fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tax Fee', style: Theme.of(context).textTheme.bodyMedium),
            Text('Rp 25', style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        const SizedBox(height: AppSize.spaceBtwItems / 2),

        // Total Order
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total Order', style: Theme.of(context).textTheme.bodyMedium),
            Text('Rp 295', style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ],
    );
  }
}
