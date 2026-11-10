import 'package:clean_ease/common/widgets/appbar/appbar.dart';
import 'package:clean_ease/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:clean_ease/common/widgets/icons/circular_icon.dart';
import 'package:clean_ease/common/widgets/images/app_rounded_image.dart';
import 'package:clean_ease/utils/constants/colors.dart';
import 'package:clean_ease/utils/constants/image_strings.dart';
import 'package:clean_ease/utils/constants/sizes.dart';
import 'package:clean_ease/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AppProductImageSlider extends StatelessWidget {
  const AppProductImageSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return AppCurvedEdgeWidget(
      child: Container(
        color: dark ? AppColors.darkergrey : AppColors.light,
        child: Stack(
          children: [
            const SizedBox(
              height: 400,
              child: Padding(
                padding: EdgeInsets.all(AppSize.productImageRadius * 2),
                child:
                    Center(child: Image(image: AssetImage(AppImages.product1))),
              ),
            ),

            // image slider
            Positioned(
              right: 0,
              bottom: 30,
              left: AppSize.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  itemCount: 4,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: AppSize.spaceBtwItems),
                  itemBuilder: (_, index) => AppRoundedImage(
                    width: 80,
                    backgroundColor: dark ? AppColors.dark : AppColors.white,
                    border: Border.all(color: AppColors.primary),
                    padding: const EdgeInsets.all(AppSize.sm),
                    imageUrl: AppImages.product1,
                  ),
                ),
              ),
            ),

            // Appbar Icon
            const AppsBar(
              showBackArrow: true,
              actions: [
                AppCilcularIcon(icon: Iconsax.heart, color: Colors.red)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
