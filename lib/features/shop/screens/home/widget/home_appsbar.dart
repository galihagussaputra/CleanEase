import 'package:clean_ease/common/widgets/appbar/appbar.dart';
import 'package:clean_ease/common/widgets/loaders/shimmer.dart';
import 'package:clean_ease/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:clean_ease/features/personalization/controller/user_controller.dart';
import 'package:clean_ease/utils/constants/colors.dart';
import 'package:clean_ease/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppHomeAppsBar extends StatelessWidget {
  const AppHomeAppsBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<UserController>()
        ? UserController.instance
        : Get.put(UserController());
    return AppsBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppTexts.homeAppbarTitle,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .apply(color: AppColors.grey)),
          Obx(
            () {
              if (controller.profileLoading.value) {
                return const AppShimmerEffect(width: 80, height: 15);
              } else {
                return Text(controller.user.value.fullName,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .apply(color: AppColors.white));
              }
            },
          ),
        ],
      ),
      actions: [
        AppCartCounterIcon(
          onPressed: () {},
          iconColor: AppColors.white,
        )
      ],
    );
  }
}
