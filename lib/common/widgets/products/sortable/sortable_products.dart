import 'package:clean_ease/common/widgets/layouts/grid_layout.dart';
import 'package:clean_ease/common/widgets/products/product_card/product_card_vertical.dart';
import 'package:clean_ease/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AppSortableProducts extends StatelessWidget {
  const AppSortableProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Dropdown
        DropdownButtonFormField(
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          onChanged: (value) {},
          items: [
            'Name',
            'Heigher Price',
            'Lower Price',
            'Sale',
            'Newest',
            'Popularity'
          ]
              .map((option) =>
                  DropdownMenuItem(value: option, child: Text(option)))
              .toList(),
        ),
        const SizedBox(height: AppSize.spaceBtwSections),

        // Product
        AppGridLayout(
            itemCount: 4,
            itemBuilder: (_, index) => const AppProductCardVertical())
      ],
    );
  }
}
