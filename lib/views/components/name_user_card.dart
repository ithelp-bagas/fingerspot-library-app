import 'package:fingerspot_library_app/helpers/shared_pref.dart';
import 'package:fingerspot_library_app/routes/app_routes.dart';
import 'package:fingerspot_library_app/views/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NameUserCard extends StatelessWidget {
  NameUserCard({super.key, required this.nameUser, required this.userId, required this.textColor, required this.fontSize, required this.fontWeight});
  final String nameUser;
  final int userId;
  final BottomNavController bottomNavController = Get.put(BottomNavController());
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
        String? nameAuth = await SharedPref().getAuthName();
        if(nameUser != nameAuth) {
          Get.toNamed(Routes.PROFILE_VISIT, arguments: {'profileId': userId});
        } else {
          bottomNavController.selectedIndex.value = 4;
          Get.toNamed(Routes.HOME);
        }
      },
      child: Text(
        nameUser,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: textColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
