import 'package:clean_ease/common/widgets/appbar/appbar.dart';
import 'package:clean_ease/common/widgets/icons/circular_icon.dart';
import 'package:clean_ease/common/widgets/layouts/grid_layout.dart';
import 'package:clean_ease/common/widgets/products/product_card/product_card_vertical.dart';
import 'package:clean_ease/features/shop/screens/home/home.dart';
import 'package:clean_ease/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppsBar(
        title:
            Text('Wishlist', style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          AppCilcularIcon(
              icon: Iconsax.add, onPressed: () => Get.to(const HomeScreen())),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSize.defaultSpace),
          child: Column(
            children: [
              AppGridLayout(
                  itemCount: 6,
                  itemBuilder: (_, index) => const AppProductCardVertical())
            ],
          ),
        ),
      ),
    );
  }
}
