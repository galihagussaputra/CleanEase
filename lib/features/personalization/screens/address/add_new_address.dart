import 'package:clean_ease/common/widgets/appbar/appbar.dart';
import 'package:clean_ease/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const AppsBar(showBackArrow: true, title: Text('Add new address')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSize.defaultSpace),
          child: Form(
            child: Column(
              children: [
                TextFormField(
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.user), labelText: 'Name')),
                const SizedBox(height: AppSize.spaceBtwInputFields),
                TextFormField(
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.mobile),
                        labelText: 'Phone Number')),
                const SizedBox(height: AppSize.spaceBtwInputFields),
                Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Iconsax.building_3),
                                labelText: 'Street'))),
                    const SizedBox(width: AppSize.spaceBtwInputFields),
                    Expanded(
                        child: TextFormField(
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Iconsax.code),
                                labelText: 'Post Code'))),
                  ],
                ),
                const SizedBox(height: AppSize.spaceBtwInputFields),
                Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Iconsax.building),
                                labelText: 'City'))),
                    const SizedBox(width: AppSize.spaceBtwInputFields),
                    Expanded(
                        child: TextFormField(
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Iconsax.activity),
                                labelText: 'State'))),
                  ],
                ),
                const SizedBox(height: AppSize.spaceBtwInputFields),
                TextFormField(
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.global),
                        labelText: 'Country')),
                const SizedBox(height: AppSize.defaultSpace),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: () {}, child: const Text('Save')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
