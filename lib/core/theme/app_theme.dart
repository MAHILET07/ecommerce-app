import 'package:flutter/material.dart';
import 'app_colors.dart';


class AppTheme {

  static ThemeData lightTheme = ThemeData(

    brightness: Brightness.light,

    scaffoldBackgroundColor:
        AppColors.lightBackground,

    colorScheme: ColorScheme.light(

      primary: AppColors.primary,

      secondary: AppColors.secondary,

    ),

  );


  static ThemeData darkTheme = ThemeData(

    brightness: Brightness.dark,

    scaffoldBackgroundColor:
        AppColors.darkBackground,

    colorScheme: ColorScheme.dark(

      primary: AppColors.primary,

      secondary: AppColors.secondary,

    ),

  );

}