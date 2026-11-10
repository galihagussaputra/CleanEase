import 'dart:async';

import 'package:clean_ease/common/widgets/success_screen/success_screen.dart';
import 'package:clean_ease/data/repositories/authentication/authentication_repository.dart';
import 'package:clean_ease/utils/constants/image_strings.dart';
import 'package:clean_ease/utils/constants/text_strings.dart';
import 'package:clean_ease/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  Timer? _timer;
  bool _isRedirecting = false;

  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  // send mail verify
  Future<void> sendEmailVerification() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null || user.emailVerified) return;

      await AuthenticationRepository.instance.sendEmailVerification();
      AppLoaders.successSnackBar(
          title: 'Email sent', message: 'Please check your inbox and verify');
    } catch (e) {
      AppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // timer
  void setTimerForAutoRedirect() {
    _timer?.cancel();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        await FirebaseAuth.instance.currentUser?.reload();
        final user = FirebaseAuth.instance.currentUser;
        if ((user?.emailVerified ?? false) && !_isRedirecting) {
          _isRedirecting = true;
          timer.cancel();
          Get.off(
            () => SuccessScreen(
              image: AppImages.staticSuccessIllustration,
              title: AppTexts.yourAccountCreatedTitle,
              subTitle: AppTexts.yourAccountCreatedSubTitle,
              onPressed: () =>
                  AuthenticationRepository.instance.screenRedirect(),
            ),
          );
        }
      },
    );
  }

  Future<void> checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified && !_isRedirecting) {
      _isRedirecting = true;
      _timer?.cancel();
      Get.off(
        () => SuccessScreen(
          image: AppImages.staticSuccessIllustration,
          title: AppTexts.yourAccountCreatedTitle,
          subTitle: AppTexts.yourAccountCreatedSubTitle,
          onPressed: () => AuthenticationRepository.instance.screenRedirect(),
        ),
      );
    }
  }
}
