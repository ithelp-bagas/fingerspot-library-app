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

class CardChildComment extends StatelessWidget {
  CardChildComment({super.key, required this.imgPath, required this.name, required this.date, required this.komentar, required this.like, required this.balasan, required this.liked, required this.commentId});
  final String imgPath;
  final String name;
  final String date;
  final String komentar;
  final int like;
  final int balasan;
  final bool liked;
  final int commentId;

  final CommentController commentController = Get.put(CommentController());

  Helper helper = Helper();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15.h),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: kGrey, width: 2.h),
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
                    imgPath.isNotEmpty
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
                        image: imgPath.isNotEmpty
                            ? DecorationImage(
                          image: CachedNetworkImageProvider(Api.imgurl + imgPath),
                          fit: BoxFit.cover,
                        )
                            : const DecorationImage(
                          image: AssetImage('assets/images/profile_large.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.h),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                    const Icon(
                      Icons.more_vert,
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                ExpandableText(
                  text: helper.renderHtmlToString(komentar),
                  style: TextStyle(
                    fontSize: p2,
                    fontWeight: regular,
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconHome(
                          icon: liked ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                          label: '$like',
                        ),
                        if (balasan > 0)
                          GestureDetector(
                            onTap: () {
                              commentController.toggleReply(commentId);
                            },
                            child: IconHome(
                              icon: Icons.message,
                              label: '$balasan Balasan',
                            ),
                          ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Balas',
                        style: TextStyle(
                          fontSize: p2,
                          fontWeight: heavy,
                          decoration: TextDecoration.underline,
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
