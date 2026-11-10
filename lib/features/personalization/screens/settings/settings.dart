import 'package:clean_ease/common/widgets/appbar/appbar.dart';
import 'package:clean_ease/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:clean_ease/common/widgets/list_title/setting_menu_title.dart';
import 'package:clean_ease/common/widgets/list_title/user_profile_title.dart';
import 'package:clean_ease/common/widgets/texts/section_heading.dart';
import 'package:clean_ease/data/repositories/authentication/authentication_repository.dart';
import 'package:clean_ease/features/personalization/screens/address/address.dart';
import 'package:clean_ease/features/personalization/screens/profile/profile.dart';
import 'package:clean_ease/features/shop/screens/order/order.dart';
import 'package:clean_ease/utils/constants/colors.dart';
import 'package:clean_ease/utils/constants/sizes.dart';
import 'package:clean_ease/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            AppPrimaryHeaderContainer(
              child: Column(
                children: [
                  AppsBar(
                      title: Text('Account',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .apply(color: AppColors.white))),

                  // user profile
                  AppUserProfileTitle(
                      onPressed: () => Get.to(() => const ProfileScreen())),
                  const SizedBox(height: AppSize.spaceBtwSections),
                ],
              ),
            ),

            // Body
            Padding(
              padding: const EdgeInsets.all(AppSize.defaultSpace),
              child: Column(
                children: [
                  const AppSectionHeading(
                      title: 'Account Settings', showActionButton: false),
                  const SizedBox(height: AppSize.spaceBtwItems),

                  // menu settings
                  AppSettingMenuTitle(
                    icon: Iconsax.safe_home,
                    title: 'My Addresses',
                    subtitle: 'Set Address Services',
                    onTap: () => Get.to(() => const UserAddressScreen()),
                  ),
                  const AppSettingMenuTitle(
                    icon: Iconsax.shopping_cart,
                    title: 'My Cart',
                    subtitle: 'Add, remove services and move to checkout',
                  ),
                  AppSettingMenuTitle(
                    icon: Iconsax.bag_tick,
                    title: 'My Orders',
                    subtitle: 'In-Progress and Completed Orders',
                    onTap: () => Get.to(() => const OrderScreen()),
                  ),
                  const AppSettingMenuTitle(
                    icon: Iconsax.bank,
                    title: 'Bank Account',
                    subtitle: 'Withdraw balance to registered bank account',
                  ),
                  const AppSettingMenuTitle(
                    icon: Iconsax.discount_shape,
                    title: 'My Coupons',
                    subtitle: 'List of all the discount coupons',
                  ),
                  const AppSettingMenuTitle(
                    icon: Iconsax.notification,
                    title: 'Notifications',
                    subtitle: 'Set any kind of notification message',
                  ),
                  const AppSettingMenuTitle(
                    icon: Iconsax.security_card,
                    title: 'Account Privacy',
                    subtitle: 'Manage data usage and connected accounts',
                  ),

                  // App Settings
                  const SizedBox(height: AppSize.spaceBtwSections),
                  const AppSectionHeading(
                      title: 'App Settings', showActionButton: false),
                  const SizedBox(height: AppSize.spaceBtwItems),
                  const AppSettingMenuTitle(
                      icon: Iconsax.document_upload,
                      title: 'Load Data',
                      subtitle: 'Upload Data to Your Cloud Firebase'),
                  AppSettingMenuTitle(
                    icon: Iconsax.location,
                    title: 'Geolocation',
                    subtitle: 'Set recommendation based on location',
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),
                  AppSettingMenuTitle(
                    icon: Iconsax.security_user,
                    title: 'Safe Mode',
                    subtitle: 'Search result is safe for all ages',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),
                  AppSettingMenuTitle(
                    icon: Iconsax.image,
                    title: 'Hd Image Quality',
                    subtitle: 'Set image quality to be seen',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),

                  // Logout Button
                  const SizedBox(height: AppSize.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () async {
                          try {
                            await AuthenticationRepository.instance.logout();
                          } catch (e) {
                            AppLoaders.errorSnackBar(
                                title: 'Oh Snap', message: e.toString());
                          }
                        },
                        child: const Text('Logout')),
                  ),
                  const SizedBox(height: AppSize.spaceBtwSections * 2.5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
