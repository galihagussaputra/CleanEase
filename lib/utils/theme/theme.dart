import 'package:clean_ease/utils/theme/custom_themes/appbar_theme.dart';
import 'package:clean_ease/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:clean_ease/utils/theme/custom_themes/checkbox_theme.dart';
import 'package:clean_ease/utils/theme/custom_themes/chip_theme.dart';
import 'package:clean_ease/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:clean_ease/utils/theme/custom_themes/outlined_button_theme.dart';
import 'package:clean_ease/utils/theme/custom_themes/text_field_theme.dart';
import 'package:clean_ease/utils/constants/colors.dart';
import 'package:clean_ease/utils/theme/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    textTheme: AppTextTheme.lightTextTheme,
    chipTheme: AppChipTheme.lightChipTheme,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarCustomTheme.lightAppBarTheme,
    checkboxTheme: AppCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: BottomSheetCustomTheme.lightBottomSheetTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: AppOutlineButtonTheme.lightOutlineButtonTheme,
    inputDecorationTheme: AppTextFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    textTheme: AppTextTheme.darkTextTheme,
    chipTheme: AppChipTheme.darkChipTheme,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarCustomTheme.darkAppBarTheme,
    checkboxTheme: AppCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: BottomSheetCustomTheme.darkBottomSheetTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: AppOutlineButtonTheme.darkOutlineButtonTheme,
    inputDecorationTheme: AppTextFieldTheme.darkInputDecorationTheme,
  );
}
