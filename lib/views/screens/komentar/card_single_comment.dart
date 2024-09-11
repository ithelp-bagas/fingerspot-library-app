import 'package:cached_network_image/cached_network_image.dart';
import 'package:fingerspot_library_app/controllers/comment_controller.dart';
import 'package:fingerspot_library_app/helpers/api.dart';
import 'package:fingerspot_library_app/helpers/helpers.dart';
import 'package:fingerspot_library_app/views/components/dialog_hapus.dart';
import 'package:fingerspot_library_app/views/components/dialog_laporkan.dart';
import 'package:fingerspot_library_app/views/components/expandable_text.dart';
import 'package:fingerspot_library_app/views/components/name_user_card.dart';
import 'package:fingerspot_library_app/views/components/profile_image_card.dart';
import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:fingerspot_library_app/views/screens/home/components/icon_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CardSingleComment extends StatelessWidget {
  CardSingleComment({super.key, required this.imgPath, required this.name, required this.date, required this.komentar, required this.like, required this.balasan, required this.liked, required this.commentId, required this.commentUserId, required this.postUserId, required this.postId, required this.parentCommentId, required this.isFirst});
  final String imgPath;
  final String name;
  final String date;
  final String komentar;
  final int like;
  final int balasan;
  final bool liked;
  final int commentId;
  final int commentUserId;
  final int postUserId;
  final int postId;
  final int parentCommentId;
  final bool isFirst;

  final CommentController commentController = Get.put(CommentController());

  Helper helper = Helper();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: kGrey, width: parentCommentId != 0 ? 1.h : 0),
          bottom: BorderSide(color: kGrey, width: parentCommentId == 0 ? .5.h : 0),
          top: BorderSide(color: kGrey, width: isFirst || parentCommentId != 0 ? 0 : .5.h),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ProfileImageCard(nameUser: name, userId: commentUserId, imagePath: imgPath),
                    ),
                    SizedBox(width: 10.h,),
                    Expanded(
                      flex: 8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              NameUserCard(
                                  nameUser: name,
                                  userId: commentUserId,
                                  textColor: Theme.of(context).textTheme.labelSmall!.color!,
                                  fontSize: p2,
                                  fontWeight: heavy
                              ),
                              SizedBox(width: 5.w,),
                              commentUserId == postUserId ?
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.h),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(3.h)
                                ),
                                child: Text(
                                  'Pemilik',
                                  style: TextStyle(
                                    fontSize: xsLabel,
                                    fontWeight: regular,
                                    color: kLight
                                  ),
                                ),
                              ) : Container()
                            ],
                          ),
                          Text(
                            helper.formatedDate(date),
                            style: TextStyle(
                              color: Theme.of(context).textTheme.labelSmall?.color,
                              fontSize: p2,
                              fontWeight: regular,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    name != commentController.nameAuth ?
                    Expanded(
                      flex: 1,
                      child: PopupMenuButton(
                        itemBuilder:  (context) => [
                          PopupMenuItem(
                            onTap: () {
                              Get.dialog(
                                DialogLaporkan(
                                    textController: commentController.reasonController,
                                    charCount: commentController.charCount,
                                    onPress: () async {
                                      if (!commentController.isLoading.value) {
                                        commentController.isLoading.value = true;

                                        // Execute the report function
                                        await commentController.reportComment(postId, commentId, commentController.reasonController.text);

                                        // Reset loading state
                                        commentController.isLoading.value = false;

                                        // Clear the controller and reset the count
                                        commentController.reasonController.clear();
                                        commentController.charCount.value = 0;
                                      }
                                    },
                                    isLoading: commentController.isLoading
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
                        ],
                      ),
                    ) : Expanded(
                      flex: 1,
                      child: PopupMenuButton(
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: Row(
                              children: [
                                const Icon(Icons.edit_note),
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
                            onTap: () async{
                              Get.dialog(
                                DialogHapus(
                                  title: "Apakah anda akan menghapus komentar ini?",
                                  onPress: () async {
                                    await commentController.deleteComment(postId, commentId);
                                  },
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.delete_outline),
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
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h,),
                ExpandableText(
                  text: helper.renderHtmlToString(komentar),
                  style: TextStyle(
                      fontSize: p2,
                      fontWeight: regular
                  ),
                ),
                SizedBox(height: 10.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await commentController.likeComment(commentId, postId);
                          },
                          child: IconHome(
                            icon: liked ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                            label: '$like',
                            color: liked ? Theme.of(context).primaryColor : Theme.of(context).iconTheme.color,
                          ),
                        ),
                        balasan > 0 ? GestureDetector(
                          onTap: () async{
                            await commentController.toggleReply(commentId);
                          },
                          child: IconHome(icon: Icons.message, label: commentController.isTappedChild[commentId] == true ? 'Sembunyikan Balasan' : '$balasan Balasan'),
                        ) : Container()
                      ],
                    ),
                    GestureDetector(
                      onTap: (){
                        commentController.toggleUserCommentReply(imgPath, name, komentar, commentId);
                      },
                      child: Text(
                        'Balas',
                        style: TextStyle(
                            fontSize: p2,
                            fontWeight: heavy,
                            decoration: TextDecoration.underline
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
