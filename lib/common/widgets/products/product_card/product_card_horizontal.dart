import 'package:clean_ease/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:clean_ease/common/widgets/icons/circular_icon.dart';
import 'package:clean_ease/common/widgets/images/app_rounded_image.dart';
import 'package:clean_ease/common/widgets/texts/app_brand_title_verified_icon.dart';
import 'package:clean_ease/common/widgets/texts/product_price_text.dart';
import 'package:clean_ease/common/widgets/texts/product_title_text.dart';
import 'package:clean_ease/utils/constants/colors.dart';
import 'package:clean_ease/utils/constants/image_strings.dart';
import 'package:clean_ease/utils/constants/sizes.dart';
import 'package:clean_ease/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AppProductCardHorizontal extends StatelessWidget {
  const AppProductCardHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return Container(
      width: 310,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.productImageRadius),
        color: dark ? AppColors.darkergrey : AppColors.softgrey,
      ),
      child: Row(
        children: [
          // Thumbnail
          AppRoundedContainer(
            height: 120,
            padding: const EdgeInsets.all(AppSize.sm),
            backgroundColor: dark ? AppColors.dark : AppColors.light,
            child: Stack(
              children: [
                // Thumbnail Image
                const SizedBox(
                  height: 104,
                  width: 104,
                  child: AppRoundedImage(
                      imageUrl: AppImages.product1, applyImageRadius: true),
                ),

                // Sale Tag
                Positioned(
                  top: 12,
                  child: AppRoundedContainer(
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
                ),

                // Favorit Icon Button
                const Positioned(
                    top: 0,
                    right: 0,
                    child: AppCilcularIcon(
                        icon: Iconsax.heart, color: Colors.red))
              ],
            ),
          ),

          // Detail
          SizedBox(
            width: 172,
            child: Padding(
              padding: const EdgeInsets.only(top: AppSize.sm, left: AppSize.sm),
              child: Column(
                children: [
                  const Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppProductTitleText(
                              title: 'Green Nike Half Sleeves Shirt',
                              smallSize: true),
                          SizedBox(height: AppSize.spaceBtwItems / 2),
                          AppBrandTitleVerifiedIcon(title: 'Nike'),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Pricing
                      const Flexible(
                          child: AppProductPriceText(price: '245.0 - 289.0')),

                      // Add to cart
                      Container(
                        decoration: const BoxDecoration(
                          color: AppColors.dark,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(AppSize.cardRadiusMd),
                            bottomRight:
                                Radius.circular(AppSize.productImageRadius),
                          ),
                        ),
                        child: const SizedBox(
                            width: AppSize.iconLg * 1.2,
                            height: AppSize.iconLg * 1.2,
                            child: Icon(Iconsax.add, color: AppColors.white)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
