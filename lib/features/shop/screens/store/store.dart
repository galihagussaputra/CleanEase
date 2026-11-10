import 'package:clean_ease/common/widgets/appbar/appbar.dart';
import 'package:clean_ease/common/widgets/appbar/tabbar.dart';
import 'package:clean_ease/common/widgets/brands/brand_card.dart';
import 'package:clean_ease/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:clean_ease/common/widgets/layouts/grid_layout.dart';
import 'package:clean_ease/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:clean_ease/common/widgets/texts/section_heading.dart';
import 'package:clean_ease/features/shop/screens/store/widget/category_tab.dart';
import 'package:clean_ease/utils/constants/colors.dart';
import 'package:clean_ease/utils/constants/sizes.dart';
import 'package:clean_ease/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        //App Bar
        appBar: AppsBar(
          title:
              Text('Store', style: Theme.of(context).textTheme.headlineMedium),
          actions: [
            AppCartCounterIcon(onPressed: () {}),
          ],
        ),
        body: NestedScrollView(
          // Header
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: AppHelperFunctions.isDarkMode(context)
                    ? AppColors.black
                    : AppColors.white,
                expandedHeight: 440,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(AppSize.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      //search bar
                      const SizedBox(height: AppSize.spaceBtwItems),
                      const AppSearchContainer(
                          text: 'Search in apps',
                          showBorder: true,
                          showBackground: false,
                          padding: EdgeInsets.zero),
                      const SizedBox(height: AppSize.spaceBtwSections),

                      //Feature Brands
                      AppSectionHeading(
                          title: 'Feature Services', onPressed: () {}),
                      const SizedBox(height: AppSize.spaceBtwItems / 1.5),

                      AppGridLayout(
                        itemCount: 4,
                        mainAxisExtent: 80,
                        itemBuilder: (_, index) {
                          return const AppBrandCard(showBorder: false);
                        },
                      ),
                    ],
                  ),
                ),

                // Tab Bar
                bottom: const AppTabBar(
                  tabs: [
                    Tab(child: Text('Cleaning')),
                    Tab(child: Text('Pest Control')),
                    Tab(child: Text('Laundry')),
                    Tab(child: Text('Electrician')),
                  ],
                ),
              ),
            ];
          },

          // Body
          body: const TabBarView(children: [
            AppCategoryTab(),
            AppCategoryTab(),
            AppCategoryTab(),
            AppCategoryTab(),
          ]),
        ),
      ),
    );
  }
}
