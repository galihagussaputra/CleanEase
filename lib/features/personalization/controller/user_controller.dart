import 'package:clean_ease/data/repositories/authentication/authentication_repository.dart';
import 'package:clean_ease/data/repositories/user/user_repository.dart';
import 'package:clean_ease/features/authentication/screens/login/login.dart';
import 'package:clean_ease/features/personalization/models/user_model.dart';
import 'package:clean_ease/features/personalization/screens/profile/widget/re_authenticate_user_login_form.dart';
import 'package:clean_ease/utils/constants/image_strings.dart';
import 'package:clean_ease/utils/constants/sizes.dart';
import 'package:clean_ease/utils/helpers/network_manager.dart';
import 'package:clean_ease/utils/popups/full_screen_loader.dart';
import 'package:clean_ease/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final hidePassword = false.obs;
  final imageUploading = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
      profileLoading.value = false;
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  // save user record
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      await fetchUserRecord();

      if (user.value.id.isEmpty) {
        if (userCredentials != null) {
          final nameParts =
              UserModel.nameParts(userCredentials.user!.displayName ?? '');
          final username = UserModel.generateUsername(
              userCredentials.user!.displayName ?? '');

          // map data
          final user = UserModel(
            id: userCredentials.user!.uid,
            firstName: nameParts[0],
            lastName:
                nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
            username: username,
            email: userCredentials.user!.email ?? '',
            phoneNumber: userCredentials.user!.phoneNumber ?? '',
            profilePicture: userCredentials.user!.photoURL ?? '',
          );

          // save user data
          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      AppLoaders.warningSnackBar(
          title: 'Data not saved',
          message:
              'Something went wrong while saving your information. You can re-save your data in your Profile');
    }
  }

  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(AppSize.md),
      title: 'Delete Account',
      middleText: 'Are you sure to delete your account?',
      confirm: ElevatedButton(
        onPressed: () async => deleteUserAccount(),
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            side: const BorderSide(color: Colors.red)),
        child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSize.lg),
            child: Text('Delete')),
      ),
      cancel: OutlinedButton(
        child: const Text('Cancel'),
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
      ),
    );
  }

  Future<void> deleteUserAccount() async {
    try {
      AppFullScreenLoader.openLoadingDialog(
          'Processing', AppImages.docerAnimation);

      final auth = AuthenticationRepository.instance;
      final currentUser = auth.authUser;
      if (currentUser == null) {
        AppFullScreenLoader.stopLoading();
        return;
      }

      final providers =
          currentUser.providerData.map((e) => e.providerId).toList();

      if (providers.contains(GoogleAuthProvider.PROVIDER_ID)) {
        final reauthenticated = await auth.reAuthenticateWithGoogle();
        if (!reauthenticated) {
          AppFullScreenLoader.stopLoading();
          return;
        }
        await auth.deleteAccount();
        AppFullScreenLoader.stopLoading();
        Get.offAll(() => const LoginScreen());
      } else if (providers.contains(EmailAuthProvider.PROVIDER_ID)) {
        AppFullScreenLoader.stopLoading();
        Get.to(() => const ReAuthenticateUserLoginForm());
      } else {
        AppFullScreenLoader.stopLoading();
        AppLoaders.warningSnackBar(
            title: 'Unsupported account',
            message:
                'This sign-in provider is not supported for account deletion.');
      }
    } catch (e) {
      AppFullScreenLoader.stopLoading();
      AppLoaders.warningSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      AppFullScreenLoader.openLoadingDialog(
          'Processing', AppImages.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AppFullScreenLoader.stopLoading();
        return;
      }

      if (!reAuthFormKey.currentState!.validate()) {
        AppFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .reAuthenticateWithEmailAndPassword(
              verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();
      verifyPassword.clear();
      AppFullScreenLoader.stopLoading();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      AppFullScreenLoader.stopLoading();
      AppLoaders.warningSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  userUploadProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
          maxHeight: 512,
          maxWidth: 512);
      if (image != null) {
        imageUploading.value = true;
        final imageUrl =
            await userRepository.uploadImage('Users/Images/Profile/', image);

        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await userRepository.updateSingleField(json);

        user.value.profilePicture = imageUrl;
        user.refresh();
        AppLoaders.successSnackBar(
            title: 'Congratulation',
            message: 'Your profile image has been updated');
      }
    } catch (e) {
      AppLoaders.errorSnackBar(
          title: 'Oh Snap', message: 'Something went wrong : $e');
    } finally {
      imageUploading.value = false;
    }
  }
}
