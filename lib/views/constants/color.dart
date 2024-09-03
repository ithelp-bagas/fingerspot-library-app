
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData darkMode = ThemeData(
  primaryColor: kPrimary,
  primaryColorDark: kDark,
  primaryColorLight: kLight,
    canvasColor: kBlack,
  scaffoldBackgroundColor: kBlack,
  brightness: Brightness.dark,
  iconTheme: const IconThemeData(
    color: kLight
  ),
  textTheme: const TextTheme(
    labelSmall: TextStyle(
      color: kLight
    ),
    labelMedium: TextStyle(
      color: kBlack
    )
  )
);

ThemeData lightMode = ThemeData(
    appBarTheme: const AppBarTheme(
      color: kLight
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: kLight
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: kLight
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: kLight
    ),
    popupMenuTheme: const PopupMenuThemeData(
      color: kLight
    ),
    primaryColor: kPrimary,
    canvasColor: kLight,
    primaryColorDark: kLight,
    primaryColorLight: kBlack,
    scaffoldBackgroundColor: kLight,
    brightness: Brightness.light,
    iconTheme: const IconThemeData(
        color: kGrey
    ),
    textTheme: const TextTheme(
        labelSmall: TextStyle(
            color: kGrey
        ),
        labelMedium: TextStyle(
            color: kGrey
        )
    )
);


const kPrimary = Color(0xff3F87B9);
const kSecondary = Color(0xff75B7EC);
const kThird = Color(0xffC3DAE9);
const kLight = Color(0xffFFFFFF);
const kGrey = Color(0xff5D6A75);
const kDisabled = Color(0xffe8e7e7);
const kBlack = Color(0xff263238);
const kDark = Color(0xff12191a);
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
