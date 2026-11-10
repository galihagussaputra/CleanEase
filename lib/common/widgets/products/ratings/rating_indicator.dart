import 'package:clean_ease/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AppRatingBarIndicator extends StatelessWidget {
  const AppRatingBarIndicator({
    super.key,
    required this.rating,
  });

  final double rating;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: rating,
      itemSize: 20,
      unratedColor: AppColors.grey,
      itemBuilder: (_, __) =>
          const Icon(Iconsax.star_1, color: AppColors.primary),
    );
  }
}
