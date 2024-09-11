import 'package:cached_network_image/cached_network_image.dart';
import 'package:fingerspot_library_app/helpers/api.dart';
import 'package:fingerspot_library_app/helpers/shared_pref.dart';
import 'package:fingerspot_library_app/routes/app_routes.dart';
import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:fingerspot_library_app/views/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CardViewers extends StatelessWidget {
  CardViewers({super.key, required this.name, required this.username, required this.imgPath, required this.userId});
  final String name;
  final String username;
  final String imgPath;
  final int userId;

  final BottomNavController bottomNavController = Get.put(BottomNavController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
        String? nameAuth = await SharedPref().getAuthName();
        if(name != nameAuth) {
          Get.toNamed(Routes.PROFILE_VISIT, arguments: {'profileId': userId});
        } else {
          bottomNavController.selectedIndex.value = 4;
          Get.toNamed(Routes.HOME);
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: Container(
          padding: EdgeInsets.all(10.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.h),
            color: Theme.of(context).primaryColor,
          ),
          child: Row(
            children: [
              imgPath.isNotEmpty
                  ? CachedNetworkImage(
                imageUrl: Api.imgurl + imgPath,
                imageBuilder: (context, imageProvider) => Container(
                  width: 40.h,
                  height: 40.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.h),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  width: 40.h,
                  height: 40.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.h),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/profile.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
                  : Container(
                width: 40.h,
                height: 40.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.h),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/profile.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 10.h,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: p2,
                      fontWeight: heavy,
                      color: kLight
                    ),
                  ),
                  Text(
                    username,
                    style: TextStyle(
                      fontSize: p3,
                      color: kLight
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
