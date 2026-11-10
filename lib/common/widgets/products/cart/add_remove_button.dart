import 'package:clean_ease/common/widgets/icons/circular_icon.dart';
import 'package:clean_ease/utils/constants/colors.dart';
import 'package:clean_ease/utils/constants/sizes.dart';
import 'package:clean_ease/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AppProductQuantity extends StatelessWidget {
  const AppProductQuantity({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppCilcularIcon(
          icon: Iconsax.minus,
          width: 32,
          height: 32,
          size: AppSize.md,
          color: AppHelperFunctions.isDarkMode(context)
              ? AppColors.white
              : AppColors.black,
          backgroundColor: AppHelperFunctions.isDarkMode(context)
              ? AppColors.darkergrey
              : AppColors.white,
        ),
        const SizedBox(width: AppSize.spaceBtwItems),
        Text('2', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(width: AppSize.spaceBtwItems),

        // add button
        const AppCilcularIcon(
          icon: Iconsax.add,
          width: 32,
          height: 32,
          size: AppSize.md,
          color: AppColors.white,
          backgroundColor: AppColors.primary,
        ),
      ],
    );
  }
}
