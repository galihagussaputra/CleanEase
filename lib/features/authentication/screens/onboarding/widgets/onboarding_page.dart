import 'package:clean_ease/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
  });

  final String image, title, subTitle;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final minHeight =
            constraints.maxHeight - AppSize.defaultSpace * 6;
        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
              AppSize.defaultSpace,
              AppSize.defaultSpace,
              AppSize.defaultSpace,
              AppSize.defaultSpace * 5),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: minHeight > 0 ? minHeight : 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  width: constraints.maxWidth * 0.8,
                  height: constraints.maxHeight * 0.45,
                  fit: BoxFit.contain,
                  image: AssetImage(image),
                ),
                const SizedBox(height: AppSize.spaceBtwSections),
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSize.spaceBtwItems),
                Text(
                  subTitle,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
