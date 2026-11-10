import 'package:clean_ease/common/widgets/appbar/appbar.dart';
import 'package:clean_ease/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:clean_ease/common/widgets/products/cart/coupon_widget.dart';
import 'package:clean_ease/common/widgets/success_screen/success_screen.dart';
import 'package:clean_ease/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:clean_ease/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:clean_ease/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:clean_ease/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:clean_ease/navigation_menu.dart';
import 'package:clean_ease/utils/constants/colors.dart';
import 'package:clean_ease/utils/constants/image_strings.dart';
import 'package:clean_ease/utils/constants/sizes.dart';
import 'package:clean_ease/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppsBar(
          showBackArrow: true,
          title: Text('Order Review',
              style: Theme.of(context).textTheme.headlineSmall)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSize.defaultSpace),
          child: Column(
            children: [
              // Items in Cart
              const AppCartItems(showAddRemoveButton: false),
              const SizedBox(height: AppSize.spaceBtwSections),

              // Coupon
              const AppCouponCode(),
              const SizedBox(height: AppSize.spaceBtwSections),

              // Billing
              AppRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(AppSize.md),
                backgroundColor: dark ? AppColors.black : AppColors.white,
                child: const Column(
                  children: [
                    // Pricing
                    AppBillingAmountSection(),
                    SizedBox(height: AppSize.spaceBtwItems),

                    // Divider
                    Divider(),
                    SizedBox(height: AppSize.spaceBtwItems),

                    //Payment Method
                    AppBillingPaymentSection(),
                    SizedBox(height: AppSize.spaceBtwItems),

                    // Address
                    AppBillingAddressSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(AppSize.defaultSpace),
        child: ElevatedButton(
            onPressed: () => Get.to(
                  () => SuccessScreen(
                    image: AppImages.staticSuccessIllustration,
                    title: 'Payment Success!',
                    subTitle: 'Your Services will be clear',
                    onPressed: () => Get.offAll(() => const NavigationMenu()),
                  ),
                ),
            child: const Text('Checkout Rp 295.0')),
      ),
    );
  }
}
