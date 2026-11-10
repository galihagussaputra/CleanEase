import 'package:clean_ease/common/widgets/images/app_rounded_image.dart';
import 'package:clean_ease/common/widgets/texts/app_brand_title_verified_icon.dart';
import 'package:clean_ease/common/widgets/texts/product_title_text.dart';
import 'package:clean_ease/utils/constants/colors.dart';
import 'package:clean_ease/utils/constants/image_strings.dart';
import 'package:clean_ease/utils/constants/sizes.dart';
import 'package:clean_ease/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';

class AppCartItem extends StatelessWidget {
  const AppCartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //image
        AppRoundedImage(
          imageUrl: AppImages.product1,
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(AppSize.sm),
          backgroundColor: AppHelperFunctions.isDarkMode(context)
              ? AppColors.darkergrey
              : AppColors.light,
        ),

        const SizedBox(width: AppSize.spaceBtwItems),

        // title price size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppBrandTitleVerifiedIcon(title: 'Nike'),
              const Flexible(
                child: AppProductTitleText(
                    title: 'Black Sport Shoes', maxLines: 1),
              ),
              //Attribute
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: 'Color ',
                        style: Theme.of(context).textTheme.bodySmall),
                    TextSpan(
                        text: 'Green ',
                        style: Theme.of(context).textTheme.bodyLarge),
                    TextSpan(
                        text: 'Size ',
                        style: Theme.of(context).textTheme.bodySmall),
                    TextSpan(
                        text: 'Uk 49 ',
                        style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
