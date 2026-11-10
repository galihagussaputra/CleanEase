import 'package:clean_ease/common/widgets/icons/circular_icon.dart';
import 'package:clean_ease/utils/constants/colors.dart';
import 'package:clean_ease/utils/constants/sizes.dart';
import 'package:clean_ease/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AppBottomAddToCart extends StatelessWidget {
  const AppBottomAddToCart({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSize.defaultSpace, vertical: AppSize.defaultSpace / 2),
      decoration: BoxDecoration(
          color: dark ? AppColors.darkergrey : AppColors.light,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppSize.cardRadiusLg),
            topRight: Radius.circular(AppSize.borderRadiusLg),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const AppCilcularIcon(
                icon: Iconsax.minus,
                backgroundColor: AppColors.darkgrey,
                width: 40,
                height: 40,
                color: AppColors.white,
              ),
              const SizedBox(width: AppSize.spaceBtwItems),
              Text('2', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(width: AppSize.spaceBtwItems),
              const AppCilcularIcon(
                icon: Iconsax.add,
                backgroundColor: AppColors.black,
                width: 40,
                height: 40,
                color: AppColors.white,
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(AppSize.md),
              backgroundColor: AppColors.black,
              side: const BorderSide(color: AppColors.black),
            ),
            child: const Text('Add to Cart'),
          ),
        ],
      ),
    );
  }
}
