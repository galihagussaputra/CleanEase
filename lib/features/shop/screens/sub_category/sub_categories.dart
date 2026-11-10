import 'package:clean_ease/common/widgets/appbar/appbar.dart';
import 'package:clean_ease/common/widgets/images/app_rounded_image.dart';
import 'package:clean_ease/common/widgets/products/product_card/product_card_horizontal.dart';
import 'package:clean_ease/common/widgets/texts/section_heading.dart';
import 'package:clean_ease/utils/constants/image_strings.dart';
import 'package:clean_ease/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class SubCategoryScreen extends StatelessWidget {
  const SubCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppsBar(title: Text('Cleaning'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSize.defaultSpace),
          child: Column(
            children: [
              // Banner
              const AppRoundedImage(
                  width: double.infinity,
                  imageUrl: AppImages.promoBanner3,
                  applyImageRadius: true),
              const SizedBox(height: AppSize.spaceBtwSections),

              // Sub-categories
              Column(
                children: [
                  // Heading
                  AppSectionHeading(title: 'Car Wash', onPressed: () {}),
                  const SizedBox(height: AppSize.spaceBtwItems / 2),

                  SizedBox(
                    height: 128,
                    child: ListView.separated(
                        itemCount: 4,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: AppSize.spaceBtwItems),
                        itemBuilder: (context, index) =>
                            const AppProductCardHorizontal()),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
