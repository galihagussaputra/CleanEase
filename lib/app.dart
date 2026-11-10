import 'package:clean_ease/bindings/general_bindings.dart';
import 'package:clean_ease/utils/constants/colors.dart';
import 'package:clean_ease/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Clean Ease',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialBinding: GeneralBindings(),
      home: const Scaffold(
          backgroundColor: AppColors.primary,
          body: Center(child: CircularProgressIndicator(color: Colors.white))),
    );
  }
}
