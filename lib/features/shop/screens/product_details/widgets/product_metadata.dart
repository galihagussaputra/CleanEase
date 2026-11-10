import 'package:clean_ease/common/widgets/images/app_circular_image.dart';
import 'package:clean_ease/common/widgets/texts/app_brand_title_verified_icon.dart';
import 'package:clean_ease/common/widgets/texts/product_price_text.dart';
import 'package:clean_ease/common/widgets/texts/product_title_text.dart';
import 'package:clean_ease/utils/constants/colors.dart';

import 'package:clean_ease/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:clean_ease/utils/constants/enums.dart';
import 'package:clean_ease/utils/constants/image_strings.dart';
import 'package:clean_ease/utils/constants/sizes.dart';
import 'package:clean_ease/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';

class AppProductMetaData extends StatelessWidget {
  const AppProductMetaData({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = AppHelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Price & Sale
        Row(
          children: [
            AppRoundedContainer(
              radius: AppSize.sm,
              backgroundColor: AppColors.secondary.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSize.sm, vertical: AppSize.xs),
              child: Text('25%',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(color: AppColors.black)),
            ),
            const SizedBox(width: AppSize.spaceBtwItems),

            // Price
            Text('Rp 250.000',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .apply(decoration: TextDecoration.lineThrough)),
            const SizedBox(width: AppSize.spaceBtwItems),
            const AppProductPriceText(price: '175', isLarge: true),
          ],
        ),
        const SizedBox(height: AppSize.spaceBtwItems / 1.5),

        // Title
        const AppProductTitleText(title: 'Green nike sport'),
        const SizedBox(height: AppSize.spaceBtwItems / 1.5),

        // stack status
        Row(
          children: [
            const AppProductTitleText(title: 'Status'),
            const SizedBox(width: AppSize.spaceBtwItems),
            Text('In Stock', style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        const SizedBox(height: AppSize.spaceBtwItems / 1.5),

        //Brand
        Row(
          children: [
            AppCircularImage(
              image: AppImages.cleaningIcon,
              width: 32,
              height: 32,
              overlayColor: darkMode ? AppColors.white : AppColors.black,
            ),
            const AppBrandTitleVerifiedIcon(
                title: 'Nike', brandTextSize: TextSize.medium),
          ],
        ),
      ],
    );
  }
}
