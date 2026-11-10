import 'package:clean_ease/common/widgets/images/app_circular_image.dart';
import 'package:clean_ease/features/personalization/controller/user_controller.dart';
import 'package:clean_ease/utils/constants/colors.dart';
import 'package:clean_ease/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AppUserProfileTitle extends StatelessWidget {
  const AppUserProfileTitle({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return ListTile(
      leading: const AppCircularImage(
          image: AppImages.lightAppLogo, width: 50, height: 50, padding: 0),
      title: Text(controller.user.value.fullName,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: AppColors.white)),
      subtitle: Text(controller.user.value.email,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .apply(color: AppColors.white)),
      trailing: IconButton(
          onPressed: onPressed,
          icon: const Icon(Iconsax.edit, color: AppColors.white)),
    );
  }
}
