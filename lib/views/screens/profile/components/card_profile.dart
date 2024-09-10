import 'package:cached_network_image/cached_network_image.dart';
import 'package:fingerspot_library_app/controllers/post_controller.dart';
import 'package:fingerspot_library_app/helpers/api.dart';
import 'package:fingerspot_library_app/helpers/helpers.dart';
import 'package:fingerspot_library_app/routes/app_routes.dart';
import 'package:fingerspot_library_app/views/components/expandable_text.dart';
import 'package:fingerspot_library_app/views/components/name_user_card.dart';
import 'package:fingerspot_library_app/views/components/profile_image_card.dart';
import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:fingerspot_library_app/views/screens/home/components/icon_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CardProfile extends StatelessWidget {
  CardProfile({super.key, required this.imgPath, required this.name, required this.date, required this.categoryName, required this.title, required this.content, required this.like, required this.comment, required this.view, required this.index, required this.postId, required this.postController, required this.userId});
  final String imgPath;
  final String name;
  final String date;
  final String categoryName;
  final String title;
  final String content;
  final int like;
  final int comment;
  final int view;
  final int index;
  final int postId;
  final PostController postController;
  final int userId;

  Helper helper = Helper();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: ProfileImageCard(nameUser: name, userId: userId, imagePath: imgPath),
            ),
            SizedBox(width: 10.h,),
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NameUserCard(
                      nameUser: name,
                      userId: userId,
                      textColor: Theme.of(context).primaryColor,
                      fontSize: p1,
                      fontWeight: heavy
                  ),
                  Text(
                    "Diperbaruhi pada ${helper.formatedDateWtime(date)}",
                    style: TextStyle(
                        color: kGrey,
                        fontSize: p2,
                        fontWeight: regular
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
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
            Expanded(
              flex: 1,
              child: PopupMenuButton(
                itemBuilder:  (context) => [
                  PopupMenuItem(
                    onTap: () {},
                    child: Row(
                      children: [
                        const Icon(
                            Icons.push_pin_outlined
                        ),
                        SizedBox(width: 5.w,),
                        Text(
                          'Pin Postingan',
                          style: TextStyle(
                              fontSize: smLabel,
                              fontWeight: regular
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    onTap: () {},
                    child: Row(
                      children: [
                        const Icon(
                            Icons.edit
                        ),
                        SizedBox(width: 5.w,),
                        Text(
                          'Edit',
                          style: TextStyle(
                              fontSize: smLabel,
                              fontWeight: regular
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    onTap: () {},
                    child: Row(
                      children: [
                        const Icon(
                            Icons.delete_outline
                        ),
                        SizedBox(width: 5.w,),
                        Text(
                          'Hapus',
                          style: TextStyle(
                              fontSize: smLabel,
                              fontWeight: regular
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    onTap: (){
                      postController.copyLink(Api.defaultUrl + postController.postList[index].link);
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.link_rounded),
                        SizedBox(width: 5.w,),
                        Text(
                          'Salin Tautan',
                          style: TextStyle(
                              fontSize: smLabel,
                              fontWeight: regular
                          ),
                        ),
                      ],
                    ),
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
        ExpandableText(
          maxLines: 2,
          text: helper.renderHtmlToString(content),
          style: TextStyle(
              fontSize: p2,
              fontWeight: regular
          ),
        ),
        SizedBox(height: 10.h,),
        Row(
          children: [
            Obx(() {
              return GestureDetector(
                child: IconHome(icon: postController.profilePostList[index].liked ? Icons.thumb_up : Icons.thumb_up_alt_outlined, label: '$like', color: postController.profilePostList[index].liked ? Theme.of(context).primaryColor : Theme.of(context).iconTheme.color,),
                onTap: () async{
                  await postController.likePost(postId, true, false);
                },
              );
            }),
            GestureDetector(
              onTap: () => Get.toNamed(Routes.KOMENTAR, arguments: {'komentar': comment, 'postId': postId}),
              child: IconHome(icon: Icons.comment_bank_outlined, label: '$comment'),
            ),
            GestureDetector(
              onTap: () => Get.toNamed(Routes.VIEWER, arguments: {'postId': postId}),
              child: IconHome(
                icon: Icons.remove_red_eye_outlined,
                label: '$view',
              ),
            ),
          ],
        ),
        const Divider(
          color: kGrey,
          thickness: 1,
        ),
      ],
    );
  }
}
