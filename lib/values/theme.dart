import 'package:flutter/material.dart';
import 'package:katakara_investor/values/colors.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: AppColor.primary,
  primarySwatch: swatch,
  useMaterial3: false,
);

ThemeData darkTheme = ThemeData(
  primaryColor: AppColor.primary,
  primarySwatch: swatch,
  useMaterial3: false,
);

const swatch = MaterialColor(
  0xFF0C923B,
  <int, Color>{
    50: Color(0xFFE4F3E8),
    100: Color(0xFFB8DFBD),
    200: Color(0xFF8CCF92),
    300: Color(0xFF5FBF67),
    400: Color(0xFF35B23E),
    500: Color(0xFF0C923B),
    600: Color(0xFF0A8135),
    700: Color(0xFF086F2D),
    800: Color(0xFF065E27),
    900: Color(0xFF044C20),
  },
);
