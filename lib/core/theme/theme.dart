import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static  border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
    borderSide: BorderSide(color: AppPallete.borderColor, width: 3),
    borderRadius: BorderRadius.circular(10),
  );
  static final darkThemeMode = ThemeData.dark().copyWith(
    chipTheme: ChipThemeData(
      color: MaterialStatePropertyAll(AppPallete.backgroundColor),
      side: BorderSide.none,
    ),
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(27),
      errorBorder: border(AppPallete.errorColor),
      border: border(),
      enabledBorder: border(),
      focusedBorder: border(AppPallete.gradient2),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppPallete.backgroundColor,
    )
  );
  
}
