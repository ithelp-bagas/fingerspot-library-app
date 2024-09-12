import 'dart:core';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fingerspot_library_app/helpers/api.dart';
import 'package:fingerspot_library_app/helpers/shared_pref.dart';
import 'package:fingerspot_library_app/routes/app_routes.dart';
import 'package:fingerspot_library_app/views/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileImageCard extends StatelessWidget {
  ProfileImageCard({super.key, required this.nameUser, required this.userId, required this.imagePath});
  final String nameUser;
  final int userId;
  final String imagePath;
  final BottomNavController bottomNavController = Get.put(BottomNavController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleTap(context),
      child: _buildImage(),
    );
  }

  Future<void> _handleTap(BuildContext context) async {
    String? nameAuth = await SharedPref().getAuthName();
    if (nameUser != nameAuth) {
      Get.toNamed(Routes.PROFILE_VISIT, arguments: {'profileId': userId});
    } else {
      bottomNavController.selectedIndex.value = 4;
      Get.toNamed(Routes.HOME);
    }
  }

  Widget _buildImage() {
    return imagePath.isNotEmpty
        ? CachedNetworkImage(
      imageUrl: Api.imgurl + imagePath,
      imageBuilder: (context, imageProvider) => _buildImageContainer(imageProvider),
      errorWidget: (context, url, error) => _buildDefaultImage(),
    )
        : _buildDefaultImage();
  }

  Widget _buildImageContainer(ImageProvider imageProvider) {
    return Container(
      width: 28.h,
      height: 28.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.h),
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildDefaultImage() {
    return Container(
      width: 28.h,
      height: 28.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.h),
        image: const DecorationImage(
          image: AssetImage('assets/images/profile.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
