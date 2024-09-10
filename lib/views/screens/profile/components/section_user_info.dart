import 'package:cached_network_image/cached_network_image.dart';
import 'package:fingerspot_library_app/helpers/api.dart';
import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionUserInfo extends StatelessWidget {
  const SectionUserInfo({super.key, required this.activityPoint, required this.totalTopics, required this.totalPost, required this.name, required this.email, required this.officeName, required this.department, required this.role, required this.imgPath});
  final String activityPoint;
  final int totalTopics;
  final int totalPost;
  final String name;
  final String email;
  final String officeName;
  final String department;
  final String role;
  final String imgPath;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(5.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: imgPath.isNotEmpty
                    ? CachedNetworkImage(
                  imageUrl: Api.imgurl + imgPath,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 55.h,
                    height: 55.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.h),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: 55.h,
                    height: 55.h,
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
                  width: 55.h,
                  height: 55.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.h),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/profile.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 2.h,),
              Expanded(
                flex: 8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          activityPoint,
                          style: TextStyle(
                              fontSize: p1,
                              fontWeight: heavy
                          ),
                        ),
                        Text(
                          'Activity Point ',
                          style: TextStyle(
                              fontSize: p2,
                              fontWeight: regular
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '$totalTopics',
                          style: TextStyle(
                              fontSize: p1,
                              fontWeight: heavy
                          ),
                        ),
                        Text(
                          'Total Topics',
                          style: TextStyle(
                              fontSize: p2,
                              fontWeight: regular
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '$totalPost',
                          style: TextStyle(
                              fontSize: p1,
                              fontWeight: heavy
                          ),
                        ),
                        Text(
                          'Total Post',
                          style: TextStyle(
                              fontSize: p2,
                              fontWeight: regular
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h,),
        Text(
          name,
          style: TextStyle(
              fontSize: p2,
              fontWeight: bold
          ),
        ),
        Text(
          email,
          style: TextStyle(
              fontSize: p2,
              fontWeight: regular
          ),
        ),
        Text(
          officeName,
          style: TextStyle(
              fontSize: p2,
              fontWeight: regular
          ),
        ),
        Text(
          '$department / $role',
          style: TextStyle(
              fontSize: p2,
              fontWeight: regular
          ),
        ),
      ],
    );
  }
}
