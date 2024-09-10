
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData light = ThemeData(
  fontFamily: 'Roboto',
  primaryColor: const Color(0xFF3f87b9),
  secondaryHeaderColor: const Color(0xFF75b7ec),
  disabledColor: const Color(0xFFBABFC4),
  brightness: Brightness.light,
  hintColor: const Color(0xFF9F9F9F),
  cardColor: Colors.white,
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: const Color(0xFF3f87b9))),
  colorScheme: const ColorScheme.light(primary: Color(0xFF3f87b9),
      tertiary: Color(0xFF3f87b9),
      tertiaryContainer: Color(0xFF005a89),
      secondary: Color(0xFF3f87b9)).copyWith(background: const Color(0xFFF3F3F3)).copyWith(error: const Color(0xFFE84D4F)),
  popupMenuTheme: const PopupMenuThemeData(color: Colors.white, surfaceTintColor: Colors.white),
  dialogTheme: const DialogTheme(surfaceTintColor: Colors.white),
  floatingActionButtonTheme: FloatingActionButtonThemeData(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(500))),
  bottomAppBarTheme: const BottomAppBarTheme(
    surfaceTintColor: Colors.white, height: 60,
    padding: EdgeInsets.symmetric(vertical: 5),
  ),
  dividerTheme: const DividerThemeData(thickness: 0.2, color: Color(0xFFA0A4A8)),
);

ThemeData dark = ThemeData(
  fontFamily: 'Roboto',
  primaryColor: const Color(0xFF3f87b9),
  secondaryHeaderColor: const Color(0xFF005a89),
  disabledColor: const Color(0xffa2a7ad),
  brightness: Brightness.dark,
  hintColor: const Color(0xFFbebebe),
  cardColor: const Color(0xFF272d34),
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: const Color(0xFF3f87b9))),
  colorScheme: const ColorScheme.dark(primary: Color(0xFF3f87b9),
      tertiary: Color(0xFF3f87b9),
      tertiaryContainer: Color(0xFF005a89),
      secondary: Color(0xFF3f87b9)).copyWith(background: const Color(0xFF191A26)).copyWith(error: const Color(0xFFdd3135)),
  popupMenuTheme: const PopupMenuThemeData(color: Color(0xFF272d34), surfaceTintColor: Color(0xFF272d34)),
  dialogTheme: const DialogTheme(surfaceTintColor: Colors.white10),
  floatingActionButtonTheme: FloatingActionButtonThemeData(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(500))),
  bottomAppBarTheme: const BottomAppBarTheme(
    surfaceTintColor: Colors.black, height: 60,
    padding: EdgeInsets.symmetric(vertical: 5),
  ),
  dividerTheme: const DividerThemeData(thickness: 0.5, color: Color(0xFFA0A4A8)),
);


const kPrimary = Color(0xff3F87B9);
const kSecondary = Color(0xff75B7EC);
const kThird = Color(0xffC3DAE9);
const kLight = Color(0xffFFFFFF);
const kLighted = Color(0xffF3F3F3);
const kGrey = Color(0xff5D6A75);
const kDisabled = Color(0xffe8e7e7);
const kBlack = Color(0xff263238);
const kDark = Color(0xff141218);
const kSuccess = Color(0xff02A859);
const kDanger = Color(0xffF04747);
const kWarning = Color(0xffFEBD15);

double h1 = 30.sp;
double h2 = 24.sp;
double h3 = 18.sp;
double h4 = 16.sp;

double p1 = 14.sp;
double p2 = 12.sp;
double p3 = 10.sp;

double xsLabel = 10.sp;
double smLabel = 14.sp;
double defLabel = 16.sp;
double lgLabel = 20.sp;
double xlLabel = 24.sp;

FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight heavy = FontWeight.w600;
FontWeight bold = FontWeight.w700;
