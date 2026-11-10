import 'package:clean_ease/features/shop/screens/cart/cart.dart';
import 'package:clean_ease/utils/constants/colors.dart';
import 'package:clean_ease/utils/helpers/helper_function.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:flutter/material.dart';

class AppCartCounterIcon extends StatelessWidget {
  const AppCartCounterIcon({
    super.key,
    this.iconColor,
    this.counterBgColor,
    this.counterTextColor,
    required this.onPressed,
  });

  final Color? iconColor, counterBgColor, counterTextColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return Stack(
      children: [
        IconButton(
            onPressed: () => Get.to(() => const CartScreen()),
            icon: Icon(Iconsax.shopping_bag, color: iconColor)),
        Positioned(
          right: 0,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color:
                  counterBgColor ?? (dark ? AppColors.white : AppColors.black),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
                child: Text('2',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .apply(color: AppColors.white, fontSizeFactor: 0.8))),
          ),
        ),
      ],
    );
  }
}
