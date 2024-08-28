import 'package:cached_network_image/cached_network_image.dart';
import 'package:fingerspot_library_app/helpers/api.dart';
import 'package:fingerspot_library_app/helpers/helpers.dart';
import 'package:fingerspot_library_app/routes/app_routes.dart';
import 'package:fingerspot_library_app/views/components/expandable_text.dart';
import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:fingerspot_library_app/views/screens/home/components/icon_home.dart';
import 'package:fingerspot_library_app/views/screens/viewers/viewers_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CardDiskusi extends StatelessWidget {
  CardDiskusi({super.key, required this.nameUser, required this.title, required this.content, required this.like, required this.comment, required this.view, required this.date, required this.imagePath, required this.postId});
  final String nameUser;
  final String title;
  final String content;
  final String like;
  final String comment;
  final String view;
  final String date;
  final String imagePath;
  final int postId;
  
  Helper helper = Helper();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.h),
      width: MediaQuery.of(context).size.width * 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  width: 28.h,
                  height: 28.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.h),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        Api.imgurl + imagePath,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.h,),
              Expanded(
                flex: 5,
                child: Text(
                  nameUser,
                  style: TextStyle(
                      color: kPrimary,
                      fontSize: p1,
                      fontWeight: heavy
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  helper.formatedDate(date),
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      color: kGrey,
                      fontSize: p2,
                      fontWeight: regular
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Expanded(
                flex: 1,
                child: Icon(
                  Icons.more_vert,
                ),
              )
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
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.DETAIL, arguments: {'postId': postId, 'imgPath': imagePath});
            },
            child: ExpandableText(
              text: helper.renderHtmlToString(content),
              style: TextStyle(
                  fontSize: p2,
                  fontWeight: regular
              ),
            ),
          ),
          SizedBox(height: 10.h,),
          Row(
            children: [
              IconHome(icon: Icons.thumb_up_alt_outlined, label: like),
              IconHome(icon: Icons.comment_bank_outlined, label: comment),
              GestureDetector(
                onTap: () => Get.toNamed(Routes.VIEWER, arguments: {'postId': postId}),
                  child: IconHome(
                    icon: Icons.remove_red_eye_outlined,
                    label: view,
                  ),
              ),
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
