import 'package:clean_ease/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:clean_ease/utils/constants/colors.dart';
import 'package:clean_ease/utils/constants/sizes.dart';
import 'package:clean_ease/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AppOrderListItems extends StatelessWidget {
  const AppOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 5,
      separatorBuilder: (_, __) =>
          const SizedBox(height: AppSize.spaceBtwItems),
      itemBuilder: (_, index) => AppRoundedContainer(
        showBorder: true,
        padding: const EdgeInsets.all(AppSize.md),
        backgroundColor: dark ? AppColors.dark : AppColors.light,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Row 1
            Row(
              children: [
                // Icon
                const Icon(Iconsax.ship),
                const SizedBox(width: AppSize.spaceBtwItems / 2),

                // Status & date
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Processing',
                        style: Theme.of(context).textTheme.bodyLarge!.apply(
                            color: AppColors.primary, fontWeightDelta: 1),
                      ),
                      Text('07 Agus 2024',
                          style: Theme.of(context).textTheme.headlineSmall),
                    ],
                  ),
                ),

                // Icon
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Iconsax.arrow_right_3,
                        size: AppSize.iconSm)),
              ],
            ),
            const SizedBox(height: AppSize.spaceBtwItems),

            // Row 2
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      // Icon
                      const Icon(Iconsax.tag),
                      const SizedBox(width: AppSize.spaceBtwItems / 2),

                      // Status & date
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Order',
                                style: Theme.of(context).textTheme.labelMedium),
                            Text('[#085y74]',
                                style: Theme.of(context).textTheme.titleMedium),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      // Icon
                      const Icon(Iconsax.calendar),
                      const SizedBox(width: AppSize.spaceBtwItems / 2),

                      // Status & date
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Shipping Date',
                                style: Theme.of(context).textTheme.labelMedium),
                            Text('08 Agus 2024',
                                style: Theme.of(context).textTheme.titleMedium),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
