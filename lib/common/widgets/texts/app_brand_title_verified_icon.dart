import 'package:clean_ease/common/widgets/texts/app_brand_title_text.dart';
import 'package:clean_ease/utils/constants/colors.dart';
import 'package:clean_ease/utils/constants/enums.dart';
import 'package:clean_ease/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AppBrandTitleVerifiedIcon extends StatelessWidget {
  const AppBrandTitleVerifiedIcon({
    super.key,
    this.textColor,
    this.maxLines = 1,
    required this.title,
    this.iconColor = AppColors.primary,
    this.textAlign = TextAlign.center,
    this.brandTextSize = TextSize.small,
  });

  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSize brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: AppBrandTitleText(
            title: title,
            color: textColor,
            maxLines: maxLines,
            textAlign: textAlign,
            brandTextSize: brandTextSize,
          ),
        ),
        const SizedBox(width: AppSize.xs),
        Icon(Iconsax.verify, color: iconColor, size: AppSize.iconXs),
      ],
    );
  }
}
