import 'package:clean_ease/common/widgets/loaders/animation_loader.dart';
import 'package:clean_ease/utils/constants/colors.dart';
import 'package:clean_ease/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppFullScreenLoader {
  static bool _isLoading = false;

  static void openLoadingDialog(String text, String animation) {
    final context = Get.overlayContext;
    if (_isLoading || context == null) return;
    _isLoading = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => PopScope(
        canPop: false,
        child: Container(
          color: AppHelperFunctions.isDarkMode(dialogContext)
              ? AppColors.dark
              : AppColors.white,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 250),
              AppAnimationLoaderWidget(text: text, animation: animation),
            ],
          ),
        ),
      ),
    );
  }

  static void stopLoading() {
    if (!_isLoading) return;
    _isLoading = false;

    final context = Get.overlayContext;
    if (context != null && Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }
}
