import 'package:cached_network_image/cached_network_image.dart';
import 'package:fingerspot_library_app/helpers/api.dart';
import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardViewers extends StatelessWidget {
  const CardViewers({super.key, required this.name, required this.username, required this.imgPath});
  final String name;
  final String username;
  final String imgPath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Container(
        padding: EdgeInsets.all(10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.h),
          color: kPrimary,
        ),
        child: Row(
          children: [
            Container(
              width: 40.h,
              height: 40.h,
              decoration: BoxDecoration(
                color: kLight,
                borderRadius: BorderRadius.circular(100.h),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    Api.imgurl + imgPath,
                  ),
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
    );
  }
}
