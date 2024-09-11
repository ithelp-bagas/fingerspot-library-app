import 'package:cached_network_image/cached_network_image.dart';
import 'package:fingerspot_library_app/controllers/post_controller.dart';
import 'package:fingerspot_library_app/helpers/api.dart';
import 'package:fingerspot_library_app/helpers/helpers.dart';
import 'package:fingerspot_library_app/main.dart';
import 'package:fingerspot_library_app/routes/app_routes.dart';
import 'package:fingerspot_library_app/views/components/dialog_laporkan.dart';
import 'package:fingerspot_library_app/views/components/expandable_text.dart';
import 'package:fingerspot_library_app/views/components/name_user_card.dart';
import 'package:fingerspot_library_app/views/components/profile_image_card.dart';
import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:fingerspot_library_app/views/screens/home/components/icon_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CardProfileVisit extends StatelessWidget {
  CardProfileVisit({super.key, required this.imgPath, required this.name, required this.date, required this.categoryName, required this.title, required this.content, required this.like, required this.comment, required this.view, required this.index, required this.postId, required this.postController, required this.userId});
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
  final int userId;

  final PostController postController;
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
                    onTap: () async{
                      await postController.addBookmark(postId, 'profile');
                    },
                    child: Obx(() => Row(
                      children: [
                        Icon(
                          postController.profilePostList[index].saved ? Icons.bookmark : Icons.bookmark_add_outlined,
                          color: postController.profilePostList[index].saved ? Theme.of(context).primaryColor : Theme.of(context).iconTheme.color,
                        ),
                        SizedBox(width: 5.w,),
                        Text(
                          postController.profilePostList[index].saved ? 'Disimpan' : 'Simpan',
                          style: TextStyle(
                              fontSize: smLabel,
                              fontWeight: regular
                          ),
                        ),
                      ],
                    ),
                    ),
                  ),
                  PopupMenuItem(
                    onTap: () {
                      Get.dialog(
                        DialogLaporkan(
                            textController: postController.reasonController,
                            charCount: postController.charCount,
                            onPress: () async {
                              if (!postController.isLoading.value) {
                                postController.isLoading.value = true;

                                // Execute the report function
                                await postController.reportPost(postId, postController.reasonController.text);

                                // Reset loading state
                                postController.isLoading.value = false;

                                // Clear the controller and reset the count
                                postController.reasonController.clear();
                                postController.charCount.value = 0;
                              }
                            },
                            isLoading: postController.isLoading
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.report_outlined),
                        SizedBox(width: 5.w,),
                        Text(
                          'Laporkan',
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
                      postController.copyLink(Api.defaultUrl + postController.profilePostList[index].link);
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
