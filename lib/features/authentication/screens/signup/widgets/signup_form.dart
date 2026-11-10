import 'package:clean_ease/features/authentication/controller/signup/signup_controller.dart';
import 'package:clean_ease/features/authentication/screens/signup/widgets/terms_conditions.dart';
import 'package:clean_ease/utils/constants/sizes.dart';
import 'package:clean_ease/utils/constants/text_strings.dart';
import 'package:clean_ease/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AppSignupForm extends StatelessWidget {
  const AppSignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          // Firs & last Name
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) =>
                      AppValidator.validateEmptyText('First Name', value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: AppTexts.firstName,
                      prefixIcon: Icon(Iconsax.user)),
                ),
              ),
              const SizedBox(width: AppSize.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) =>
                      AppValidator.validateEmptyText('Last Name', value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: AppTexts.lastName,
                      prefixIcon: Icon(Iconsax.user)),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSize.spaceBtwInputFields),

          // Username
          TextFormField(
            controller: controller.username,
            validator: (value) =>
                AppValidator.validateEmptyText('Username', value),
            expands: false,
            decoration: const InputDecoration(
                labelText: AppTexts.username,
                prefixIcon: Icon(Iconsax.user_edit)),
          ),
          const SizedBox(height: AppSize.spaceBtwInputFields),

          // Email
          TextFormField(
            controller: controller.email,
            validator: (value) => AppValidator.validateEmail(value),
            decoration: const InputDecoration(
                labelText: AppTexts.email, prefixIcon: Icon(Iconsax.direct)),
          ),
          const SizedBox(height: AppSize.spaceBtwInputFields),

          // Phone number
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => AppValidator.validatePhoneNumber(value),
            decoration: const InputDecoration(
                labelText: AppTexts.phoneNo, prefixIcon: Icon(Iconsax.call)),
          ),
          const SizedBox(height: AppSize.spaceBtwInputFields),

          // Password
          Obx(
            () => TextFormField(
              validator: (value) =>
                  AppValidator.validateStrongPassword(value),
              controller: controller.password,
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                labelText: AppTexts.password,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed: () => controller.hidePassword.value =
                      !controller.hidePassword.value,
                  icon: Icon(controller.hidePassword.value
                      ? Iconsax.eye_slash
                      : Iconsax.eye),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSize.spaceBtwInputFields),

          // Term & Condition
          const AppTermConditionSignup(),
          const SizedBox(height: AppSize.spaceBtwSections),

          // Sign Up Button
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => controller.signup(),
                  child: const Text(AppTexts.createAccount)))
        ],
      ),
    );
  }
}
