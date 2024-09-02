import 'package:cached_network_image/cached_network_image.dart';
import 'package:fingerspot_library_app/controllers/comment_controller.dart';
import 'package:fingerspot_library_app/helpers/api.dart';
import 'package:fingerspot_library_app/helpers/helpers.dart';
import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CardCommentReplies extends StatelessWidget {
  CardCommentReplies({super.key, required this.imgPath, required this.name, required this.comment});
  final String imgPath;
  final String name;
  final String comment;

  Helper helper = Helper();
  final CommentController commentController = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.h),
      width: double.infinity,
      decoration: const BoxDecoration(
          color: kDisabled
      ),
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
                    Text(
                      name,
                      style: TextStyle(
                        color: kBlack,
                        fontSize: p2,
                        fontWeight: heavy,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                    onPressed: () {
                      commentController.repliedTap.value = false;
                    },
                    icon: const Icon(Icons.clear)
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h,),
          Text(
            helper.renderHtmlToString(comment),
            style: TextStyle(
              fontSize: p2,
              fontWeight: regular
            ),
          ),
        ],
      ),
    );
  }
}
