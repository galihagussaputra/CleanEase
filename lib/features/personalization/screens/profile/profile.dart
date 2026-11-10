import 'package:clean_ease/common/widgets/appbar/appbar.dart';
import 'package:clean_ease/common/widgets/images/app_circular_image.dart';
import 'package:clean_ease/common/widgets/loaders/shimmer.dart';
import 'package:clean_ease/common/widgets/texts/section_heading.dart';
import 'package:clean_ease/features/personalization/controller/user_controller.dart';
import 'package:clean_ease/features/personalization/screens/profile/widget/change_name.dart';
import 'package:clean_ease/features/personalization/screens/profile/widget/profile_menu.dart';
import 'package:clean_ease/utils/constants/image_strings.dart';
import 'package:clean_ease/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: const AppsBar(showBackArrow: true, title: Text('Profile')),

      //body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSize.defaultSpace),
          child: Column(
            children: [
              // Profile picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(() {
                      final networkImage = controller.user.value.profilePicture;
                      final image = networkImage.isNotEmpty
                          ? networkImage
                          : AppImages.user;
                      return controller.imageUploading.value
                          ? const AppShimmerEffect(
                              width: 80, height: 80, radius: 80)
                          : AppCircularImage(
                              image: image,
                              width: 80,
                              height: 80,
                              isNetworkImage: networkImage.isNotEmpty);
                    }),
                    TextButton(
                        onPressed: () => controller.userUploadProfilePicture(),
                        child: const Text('Change Profile Picture')),
                  ],
                ),
              ),

              // Details
              const SizedBox(height: AppSize.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: AppSize.spaceBtwItems),

              // Heading
              const AppSectionHeading(
                  title: 'Profile Information', showActionButton: false),
              const SizedBox(height: AppSize.spaceBtwItems),

              AppProfileMenu(
                title: 'Name',
                value: controller.user.value.fullName,
                onPressed: () => Get.to(() => const ChangeName()),
              ),
              AppProfileMenu(
                title: 'Username',
                value: controller.user.value.username,
                onPressed: () {},
              ),

              const SizedBox(height: AppSize.spaceBtwItems),
              const Divider(),
              const SizedBox(height: AppSize.spaceBtwItems),

              //Heading personal info
              const AppSectionHeading(
                  title: 'Personal Information', showActionButton: false),
              const SizedBox(height: AppSize.spaceBtwItems),

              AppProfileMenu(
                title: 'User Id',
                value: controller.user.value.id,
                icon: Iconsax.copy,
                onPressed: () {},
              ),
              AppProfileMenu(
                title: 'E-mail',
                value: controller.user.value.email,
                onPressed: () {},
              ),

              AppProfileMenu(
                title: 'Phone Number',
                value: controller.user.value.phoneNumber,
                onPressed: () {},
              ),
              AppProfileMenu(
                title: 'Gender',
                value: 'Male',
                onPressed: () {},
              ),
              AppProfileMenu(
                title: 'Date of Birth',
                value: '10 Agustus 1998',
                onPressed: () {},
              ),
              const Divider(),
              const SizedBox(height: AppSize.spaceBtwItems),

              Center(
                child: TextButton(
                  onPressed: () => controller.deleteAccountWarningPopup(),
                  child: const Text('Close Account',
                      style: TextStyle(color: Colors.red)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
