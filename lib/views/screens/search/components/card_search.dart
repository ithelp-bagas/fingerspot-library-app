import 'package:cached_network_image/cached_network_image.dart';
import 'package:fingerspot_library_app/helpers/api.dart';
import 'package:fingerspot_library_app/helpers/helpers.dart';
import 'package:fingerspot_library_app/routes/app_routes.dart';
import 'package:fingerspot_library_app/views/components/name_user_card.dart';
import 'package:fingerspot_library_app/views/components/profile_image_card.dart';
import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:fingerspot_library_app/views/screens/search/components/icon_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CardSearch extends StatelessWidget {
  CardSearch({super.key, required this.index, required this.namaUser, required this.imgPath, required this.categoryName, required this.title, required this.date, required this.viewed, required this.commented, required this.postId, required this.userId});
  final int index;
  final String namaUser;
  final String imgPath;
  final String categoryName;
  final String title;
  final String date;
  final int viewed;
  final int commented;
  final int postId;
  final int userId;


  Helper helper = Helper();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            '0$index',
            style: TextStyle(
                color: kThird,
                fontSize: h2,
                fontWeight: heavy
            ),
          ),
        ),
        Expanded(
          flex: 9,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ProfileImageCard(nameUser: namaUser, userId: userId, imagePath: imgPath),
                    ),
                    SizedBox(width: 5.h,),
                    Expanded(
                      flex: 5,
                      child: NameUserCard(
                          nameUser: namaUser,
                          userId: userId,
                          textColor: Theme.of(context).textTheme.labelSmall!.color!,
                          fontSize: p2,
                          fontWeight: regular
                      )
                    ),
                    Expanded(
                      flex: 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.chat, size: p2, color: Theme.of(context).primaryColor,),
                          SizedBox(width: 5.w,),
                          Text(
                            "Topik $categoryName",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: p3,
                                fontWeight: heavy
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h,),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: p1,
                      fontWeight: heavy
                  ),
                ),
                SizedBox(height: 10.h,),
                Row(
                  children: [
                    GestureDetector(
                        onTap: (){
                          Get.toNamed(Routes.VIEWER, arguments: {'postId': postId});
                        },
                        child: IconSearch(icon: Icons.remove_red_eye_outlined, label: "$viewed Dilihat")
                    ),
                    GestureDetector(
                        onTap: () => Get.toNamed(Routes.KOMENTAR, arguments: {'komentar': commented, 'postId': postId}),
                        child: IconSearch(icon: Icons.comment_bank_outlined, label: "$commented Komentar")),
                    Icon(
                      Icons.circle,
                      size: 4.sp,
                    ),
                    SizedBox(width: 10.h),
                    Text(
                      'Dibuat ${helper.dayDiff(date)}',
                      style: TextStyle(
                          fontSize: p3
                      ),
                    )
                  ],
                ),
                const Divider(
                  color: kGrey,
                  thickness: 1,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CardRekomendasi extends StatelessWidget {
  CardRekomendasi({super.key, required this.imgPath, required this.nameUser, required this.categoryName, required this.title, required this.viewed, required this.commented, required this.date, required this.postId, required this.userId});
  final String imgPath;
  final String nameUser;
  final String categoryName;
  final String title;
  final int viewed;
  final int commented;
  final String date;
  final int postId;
  final int userId;
  
  Helper helper = Helper();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: ProfileImageCard(nameUser: nameUser, userId: userId, imagePath: imgPath),
              ),
              SizedBox(width: 10.h,),
              Expanded(
                flex: 9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NameUserCard(
                        nameUser: nameUser,
                        userId: userId,
                        textColor: Theme.of(context).textTheme.labelSmall!.color!,
                        fontSize: p2,
                        fontWeight: regular
                    ),
                    Row(
                      children: [
                        Icon(Icons.chat, size: p2, color: Theme.of(context).primaryColor,),
                        SizedBox(width: 5.w,),
                        Text(
                          "Topik $categoryName",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: p3,
                              fontWeight: heavy
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                )
              ),
            ],
          ),
          SizedBox(height: 10.h,),
          Text(
            title,
            style: TextStyle(
                fontSize: p1,
                fontWeight: heavy
            ),
          ),
          SizedBox(height: 10.h,),
          Row(
            children: [
              GestureDetector(
                  onTap: (){
                    Get.toNamed(Routes.VIEWER, arguments: {'postId': postId});
                  },
                  child: IconSearch(icon: Icons.remove_red_eye_outlined, label: "$viewed Dilihat")
              ),
              GestureDetector(
                  onTap: () => Get.toNamed(Routes.KOMENTAR, arguments: {'komentar': commented, 'postId': postId}),
                  child: IconSearch(icon: Icons.comment_bank_outlined, label: "$commented Komentar")),
              Icon(
                Icons.circle,
                size: 4.sp,
                color: kGrey,
              ),
              SizedBox(width: 10.h),
              Text(
                'Dibuat ${helper.dayDiff(date)}',
                style: TextStyle(
                    fontSize: p3
                ),
              )
            ],
          ),
          const Divider(
            color: kGrey,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}

