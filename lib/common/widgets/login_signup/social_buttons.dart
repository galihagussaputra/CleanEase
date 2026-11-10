import 'package:clean_ease/features/authentication/controller/login/login_controller.dart';
import 'package:clean_ease/utils/constants/colors.dart';
import 'package:clean_ease/utils/constants/image_strings.dart';
import 'package:clean_ease/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSocialButtons extends StatelessWidget {
  const AppSocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<LoginController>()
        ? LoginController.instance
        : Get.put(LoginController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.grey),
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
              onPressed: () => controller.googleSignIn(),
              icon: const Image(
                  width: AppSize.iconMd,
                  height: AppSize.iconMd,
                  image: AssetImage(AppImages.google))),
        ),
        const SizedBox(width: AppSize.spaceBtwItems),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.grey),
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
              onPressed: () {},
              icon: const Image(
                  width: AppSize.iconMd,
                  height: AppSize.iconMd,
                  image: AssetImage(AppImages.facebook))),
        ),
      ],
    );
  }
}
