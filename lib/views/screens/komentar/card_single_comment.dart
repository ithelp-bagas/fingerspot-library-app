import 'package:cached_network_image/cached_network_image.dart';
import 'package:fingerspot_library_app/controllers/comment_controller.dart';
import 'package:fingerspot_library_app/helpers/api.dart';
import 'package:fingerspot_library_app/helpers/helpers.dart';
import 'package:fingerspot_library_app/views/components/expandable_text.dart';
import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:fingerspot_library_app/views/screens/home/components/icon_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CardSingleComment extends StatelessWidget {
  CardSingleComment({super.key, required this.imgPath, required this.name, required this.date, required this.komentar, required this.like, required this.balasan, required this.liked, required this.commentId, required this.commentUserId, required this.postUserId, required this.postId});
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

  final CommentController commentController = Get.put(CommentController());

  Helper helper = Helper();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: kPrimary, width: 5.h),
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
                      child: imgPath.isNotEmpty
                          ? CachedNetworkImage(
                        imageUrl: Api.imgurl + imgPath,
                        imageBuilder: (context, imageProvider) => Container(
                          width: 28.h,
                          height: 28.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.h),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          width: 28.h,
                          height: 28.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.h),
                            image: const DecorationImage(
                              image: AssetImage('assets/images/profile_large.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                          : Container(
                        width: 28.h,
                        height: 28.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.h),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/profile_large.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.h,),
                    Expanded(
                      flex: 8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                name,
                                style: TextStyle(
                                  color: kBlack,
                                  fontSize: p2,
                                  fontWeight: heavy,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(width: 5.w,),
                              commentUserId == postUserId ?
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.h),
                                decoration: BoxDecoration(
                                  color: kPrimary,
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
                              color: kGrey,
                              fontSize: p2,
                              fontWeight: regular,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.more_vert,
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
                            color: liked ? kPrimary : kBlack,
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
          Container(
            height: 1.h,
            color: kGrey,
          )
        ],
      ),
    );
  }
}
