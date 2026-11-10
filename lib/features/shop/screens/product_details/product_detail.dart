import 'package:clean_ease/common/widgets/texts/section_heading.dart';
import 'package:clean_ease/features/shop/screens/product_details/widgets/bottom_add_to_cart.dart';
import 'package:clean_ease/features/shop/screens/product_details/widgets/product_atribut.dart';
import 'package:clean_ease/features/shop/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:clean_ease/features/shop/screens/product_details/widgets/product_metadata.dart';
import 'package:clean_ease/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:clean_ease/features/shop/screens/product_reviews/product_review.dart';
import 'package:clean_ease/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:readmore/readmore.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const AppBottomAddToCart(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // product image slider
            const AppProductImageSlider(),

            // product detail
            Padding(
              padding: const EdgeInsets.only(
                  right: AppSize.defaultSpace,
                  left: AppSize.defaultSpace,
                  bottom: AppSize.defaultSpace),
              child: Column(
                children: [
                  // Rating & share button
                  const AppRatingAndShare(),

                  // Price Title Stock Brand
                  const AppProductMetaData(),

                  // Attribute
                  const AppProductAtributes(),
                  const SizedBox(height: AppSize.spaceBtwSections),

                  // Checkout button
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {}, child: const Text('Checkout'))),
                  const SizedBox(height: AppSize.spaceBtwSections),

                  // Description
                  const AppSectionHeading(
                      title: 'Description', showActionButton: false),
                  const SizedBox(height: AppSize.spaceBtwItems),
                  const ReadMoreText(
                    'A Flutter plugin that allows for expanding and collapsing text with the added capability to style and interact with specific patterns in the text like hashtags, URLs',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' Show more',
                    trimExpandedText: ' Less',
                    moreStyle: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w800),
                  ),

                  // Review
                  const Divider(),
                  const SizedBox(height: AppSize.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const AppSectionHeading(
                          title: 'Review(1999)', showActionButton: false),
                      IconButton(
                          icon: const Icon(Iconsax.arrow_right_3, size: 18),
                          onPressed: () =>
                              Get.to(() => const ProductReviewScreen())),
                    ],
                  ),
                  const SizedBox(height: AppSize.spaceBtwSections),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
