import 'package:clean_ease/common/widgets/appbar/appbar.dart';
import 'package:clean_ease/features/personalization/controller/update_name_controller.dart';
import 'package:clean_ease/utils/constants/sizes.dart';
import 'package:clean_ease/utils/constants/text_strings.dart';
import 'package:clean_ease/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      appBar: AppsBar(
        showBackArrow: true,
        title: Text('Change Name',
            style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSize.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Use real name for easy verification. This name will appear on several pages.',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: AppSize.spaceBtwSections),
            Form(
                key: controller.updateUserNameFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.firstName,
                      validator: (value) =>
                          AppValidator.validateEmptyText('First Name', value),
                      expands: false,
                      decoration: const InputDecoration(
                          labelText: AppTexts.firstName,
                          prefixIcon: Icon(Iconsax.user)),
                    ),
                    const SizedBox(height: AppSize.spaceBtwInputFields),
                    TextFormField(
                      controller: controller.lastName,
                      validator: (value) =>
                          AppValidator.validateEmptyText('Last Name', value),
                      expands: false,
                      decoration: const InputDecoration(
                          labelText: AppTexts.lastName,
                          prefixIcon: Icon(Iconsax.user)),
                    ),
                  ],
                )),
            const SizedBox(height: AppSize.spaceBtwSections),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => controller.updateUserName(),
                  child: const Text('save')),
            ),
          ],
        ),
      ),
    );
  }
}
