import 'package:clean_ease/common/styles/shadows.dart';
import 'package:clean_ease/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:clean_ease/common/widgets/icons/circular_icon.dart';
import 'package:clean_ease/common/widgets/images/app_rounded_image.dart';
import 'package:clean_ease/common/widgets/texts/app_brand_title_verified_icon.dart';
import 'package:clean_ease/common/widgets/texts/product_price_text.dart';
import 'package:clean_ease/common/widgets/texts/product_title_text.dart';
import 'package:clean_ease/features/shop/screens/product_details/product_detail.dart';
import 'package:clean_ease/utils/constants/colors.dart';
import 'package:clean_ease/utils/constants/image_strings.dart';
import 'package:clean_ease/utils/constants/sizes.dart';
import 'package:clean_ease/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AppProductCardVertical extends StatelessWidget {
  const AppProductCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () => Get.to(() => const ProductDetailScreen()),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [AppShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(AppSize.productImageRadius),
          color: dark ? AppColors.darkergrey : AppColors.white,
        ),
        child: Column(
          children: [
            AppRoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(AppSize.sm),
              backgroundColor: dark ? AppColors.dark : AppColors.light,
              child: Stack(
                children: [
                  //thumbnail image
                  const AppRoundedImage(
                      imageUrl: AppImages.product1, applyImageRadius: true),

                  //Sale Tag
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
            const SizedBox(height: AppSize.spaceBtwItems / 2),

            // Details
            const Padding(
              padding: EdgeInsets.only(left: AppSize.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppProductTitleText(title: 'Green Nike Air', smallSize: true),
                  SizedBox(height: AppSize.spaceBtwItems / 2),
                  AppBrandTitleVerifiedIcon(title: 'Nike'),
                ],
              ),
            ),

            const Spacer(),
            //price row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(left: AppSize.sm),
                    child: AppProductPriceText(price: '35.0'),
                  ),
                ),

                //Add cart button
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.dark,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppSize.cardRadiusMd),
                      bottomRight: Radius.circular(AppSize.productImageRadius),
                    ),
                  ),
                  child: const SizedBox(
                      width: AppSize.iconLg * 1.2,
                      height: AppSize.iconLg * 1.2,
                      child: Icon(Iconsax.add, color: AppColors.white)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
