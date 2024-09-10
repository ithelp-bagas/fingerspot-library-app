import 'package:cached_network_image/cached_network_image.dart';
import 'package:fingerspot_library_app/controllers/post_controller.dart';
import 'package:fingerspot_library_app/helpers/api.dart';
import 'package:fingerspot_library_app/helpers/helpers.dart';
import 'package:fingerspot_library_app/helpers/shared_pref.dart';
import 'package:fingerspot_library_app/routes/app_routes.dart';
import 'package:fingerspot_library_app/views/components/expandable_text.dart';
import 'package:fingerspot_library_app/views/components/name_user_card.dart';
import 'package:fingerspot_library_app/views/components/profile_image_card.dart';
import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:fingerspot_library_app/views/screens/home/components/icon_home.dart';
import 'package:fingerspot_library_app/views/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CardDiskusi extends StatelessWidget {
  CardDiskusi({super.key, required this.nameUser, required this.title, required this.content, required this.like, required this.comment, required this.view, required this.date, required this.imagePath, required this.postId, required this.index, required this.userId});
  final String nameUser;
  final String title;
  final String content;
  final String like;
  final int comment;
  final String view;
  final String date;
  final String imagePath;
  final int postId;
  final int index;
  final int userId;
  
  Helper helper = Helper();

  final PostController postController = Get.put(PostController());
  final BottomNavController bottomNavController = Get.put(BottomNavController());

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
                child: ProfileImageCard(nameUser: nameUser, userId: userId, imagePath: imagePath),
              ),
              SizedBox(width: 10.h,),
              Expanded(
                flex: 5,
                child: NameUserCard(
                    nameUser: nameUser,
                    userId: userId,
                    textColor: Theme.of(context).primaryColor,
                    fontSize: p1,
                    fontWeight: heavy
                )
              ),
              Expanded(
                flex: 3,
                child: Text(
                  helper.formatedDate(date),
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontSize: p2,
                      fontWeight: regular
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Expanded(
                flex: 1,
                child: PopupMenuButton(
                  itemBuilder:  (context) => [
                    PopupMenuItem(
                      onTap: () async{
                        await postController.addBookmark(postId, 'home');
                      },
                      child: Obx(() => Row(
                          children: [
                            Icon(
                              postController.postList[index].saved ? Icons.bookmark : Icons.bookmark_add_outlined,
                              color: postController.postList[index].saved ? Theme.of(context).primaryColor : Theme.of(context).iconTheme.color,
                            ),
                            SizedBox(width: 5.w,),
                            Text(
                              postController.postList[index].saved ? 'Disimpan' : 'Simpan',
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
                          Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Material(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min, // This makes the dialog take only as much space as needed
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10),
                                    Center(
                                      child: Text(
                                        "Laporkan",
                                        style: TextStyle(
                                          fontSize: p1,
                                          fontWeight: heavy,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    Text(
                                      "Alasan : ",
                                      style: TextStyle(
                                        fontSize: p2,
                                        fontWeight: regular,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    SizedBox(height: 10.h),
                                    TextFormField(
                                      controller: postController.reasonController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.h),
                                        ),
                                      ),
                                      minLines: 3,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                    ),
                                    const SizedBox(height: 20),
                                    //Buttons
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Obx(
                                              () => Expanded(
                                            child: Text(
                                              '${postController.charCount.value}/300',
                                              style: TextStyle(
                                                fontSize: p3,
                                                fontWeight: regular,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Obx(
                                                () => ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                foregroundColor: kLight,
                                                backgroundColor: postController.charCount.value < 1 ? kGrey : Theme.of(context).primaryColor,
                                                minimumSize: const Size(0, 45),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                              ),
                                              onPressed: postController.charCount.value < 1
                                                  ? () {}
                                                  : () async {
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
                                              child: postController.isLoading.value
                                                  ? const CircularProgressIndicator()
                                                  : const Text('KIRIM'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.DETAIL, arguments: {'postId': postId, 'imgPath': imagePath, 'liked': postController.postList[index].liked});
            },
            child: Text(
              title,
              style: TextStyle(
                  fontSize: p1,
                  fontWeight: heavy
              ),
            ),
          ),
          SizedBox(height: 10.h,),
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.DETAIL, arguments: {'postId': postId, 'imgPath': imagePath, 'liked': postController.postList[index].liked});
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
              Obx(() {
                return GestureDetector(
                  child: IconHome(icon: postController.postList[index].liked ? Icons.thumb_up : Icons.thumb_up_alt_outlined, label: like, color: postController.postList[index].liked ? Theme.of(context).primaryColor : Theme.of(context).iconTheme.color,),
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
