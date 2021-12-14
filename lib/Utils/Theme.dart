// ignore_for_file: file_names

import 'package:flutter/material.dart';

Color bgColor = const Color(0xFF22252D);
Color primaryColor = const Color(0xFF373D41);
Color secondaryColor = const Color(0xFFF20028);
Color borderColor = const Color(0xFF606168);

ThemeData appTheme = ThemeData(
  primaryColor: primaryColor,
  scaffoldBackgroundColor: bgColor,
  appBarTheme: AppBarTheme(
    backgroundColor: bgColor,
    elevation: 0.0,
  ),
  // colorScheme: ColorScheme.fromSwatch().copyWith(secondary: secondaryColor),
  brightness: Brightness.dark,
  dividerColor: borderColor,
  applyElevationOverlayColor: true,
);
