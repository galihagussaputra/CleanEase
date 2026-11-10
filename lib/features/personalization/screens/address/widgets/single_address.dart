import 'package:clean_ease/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:clean_ease/utils/constants/colors.dart';
import 'package:clean_ease/utils/constants/sizes.dart';
import 'package:clean_ease/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AppSingleAddress extends StatelessWidget {
  const AppSingleAddress({super.key, required this.selectedAddress});

  final bool selectedAddress;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return AppRoundedContainer(
      width: double.infinity,
      showBorder: true,
      padding: const EdgeInsets.all(AppSize.md),
      backgroundColor: selectedAddress
          ? AppColors.primary.withOpacity(0.5)
          : Colors.transparent,
      borderColor: selectedAddress
          ? Colors.transparent
          : dark
              ? AppColors.darkergrey
              : AppColors.grey,
      margin: const EdgeInsets.only(bottom: AppSize.spaceBtwItems),
      child: Stack(
        children: [
          Positioned(
            right: 5,
            top: 0,
            child: Icon(
              selectedAddress ? Iconsax.tick_circle : null,
              color: selectedAddress
                  ? dark
                      ? AppColors.light
                      : AppColors.dark
                  : null,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Galih Agus',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppSize.sm / 2),
              const Text('(+628) 740 847 448',
                  maxLines: 1, overflow: TextOverflow.ellipsis),
              const SizedBox(height: AppSize.sm / 2),
              const Text('Delima 1 Blok C3 No 3 Tangerang', softWrap: true),
            ],
          ),
        ],
      ),
    );
  }
}
