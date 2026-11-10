import 'package:clean_ease/features/authentication/controller/forget_password/forget_password_controller.dart';
import 'package:clean_ease/utils/constants/sizes.dart';
import 'package:clean_ease/utils/constants/text_strings.dart';
import 'package:clean_ease/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(AppSize.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Heading
            Text(AppTexts.forgetPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: AppSize.spaceBtwItems),
            Text(AppTexts.forgetPasswordSubTitle,
                style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: AppSize.spaceBtwSections * 2),

            //Text field
            Form(
              key: controller.forgetPasswordFromKey,
              child: TextFormField(
                controller: controller.email,
                validator: AppValidator.validateEmail,
                decoration: const InputDecoration(
                    labelText: AppTexts.email,
                    prefixIcon: Icon(Iconsax.direct_right)),
              ),
            ),
            const SizedBox(height: AppSize.spaceBtwSections),

            //Button submit
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => controller.sendPasswordResetEmail(),
                    child: const Text(AppTexts.submit))),
          ],
        ),
      ),
    );
  }
}
