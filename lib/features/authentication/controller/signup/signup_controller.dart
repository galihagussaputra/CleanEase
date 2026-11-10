import 'package:clean_ease/data/repositories/authentication/authentication_repository.dart';
import 'package:clean_ease/data/repositories/user/user_repository.dart';
import 'package:clean_ease/features/authentication/screens/signup/verify_email.dart';
import 'package:clean_ease/features/personalization/models/user_model.dart';
import 'package:clean_ease/utils/constants/image_strings.dart';
import 'package:clean_ease/utils/helpers/network_manager.dart';
import 'package:clean_ease/utils/popups/full_screen_loader.dart';
import 'package:clean_ease/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  void signup() async {
    try {
      // Loading
      AppFullScreenLoader.openLoadingDialog(
          'We are processing your information...', AppImages.docerAnimation);

      // check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AppFullScreenLoader.stopLoading();
        return;
      }

      // form validation
      if (!signupFormKey.currentState!.validate()) {
        AppFullScreenLoader.stopLoading();
        return;
      }

      // Privacy policy
      if (!privacyPolicy.value) {
        AppFullScreenLoader.stopLoading();
        AppLoaders.warningSnackBar(
            title: 'Accept Privacy Policy',
            message:
                'In order to create account, you must have to read and accept the Privacy Policy & Term of Use.');
        return;
      }

      // Register
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      // Auth user data in firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: username.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      try {
        await userRepository.saveUserRecord(newUser);
      } catch (_) {
        try {
          await userRepository.removeUserRecord(newUser.id);
        } catch (_) {}
        try {
          await userCredential.user?.delete();
        } catch (_) {}
        rethrow;
      }

      // Remove loader
      AppFullScreenLoader.stopLoading();

      // Success Message
      AppLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your account has been created. Verify email to continue');

      // Move to email verify
      Get.to(() => VerifyEmailScreen(email: email.text.trim()));
    } catch (e) {
      // Remove loader
      AppFullScreenLoader.stopLoading();

      // show error
      AppLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
