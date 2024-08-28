import 'package:cached_network_image/cached_network_image.dart';
import 'package:fingerspot_library_app/controllers/post_controller.dart';
import 'package:fingerspot_library_app/helpers/api.dart';
import 'package:fingerspot_library_app/helpers/helpers.dart';
import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({super.key});

  final PostController postController = Get.put(PostController());
  final Helper helper = Helper();

  Future<void> _fetchPostDetails(int postId) async {
    await postController.getDetailPost(postId);
  }

  @override
  Widget build(BuildContext context) {
    var params = Get.arguments;
    int postId = params['postId'] as int;
    String imgPath = params['imgPath'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Diskusi'),
        centerTitle: true,
      ),
      body: FutureBuilder<void>(
        future: _fetchPostDetails(postId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Show loading indicator
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}')); // Show error message
          } else {
            var post = postController.detailPost.value;
            if (post == null) {
              return Center(child: Text('No data available')); // Show message if no data
            }
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10.h),
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
                                  Api.imgurl + imgPath,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.h,),
                        Expanded(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${post.user.firstname} ${post.user.lastname}',
                                style: TextStyle(
                                  color: kPrimary,
                                  fontSize: p1,
                                  fontWeight: heavy,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                helper.dayDiff(post.createdAt),
                                textAlign: TextAlign.end,
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
                        Expanded(
                          flex: 3,
                          child: Text(
                            "Topik",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: kGrey,
                              fontSize: p2,
                              fontWeight: regular,
                            ),
                            overflow: TextOverflow.ellipsis,
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
                    Text(
                      post.title,
                      style: TextStyle(
                        fontSize: p1,
                        fontWeight: heavy
                      ),
                    ),
                    SizedBox(height: 10.h,),
                    Text(
                      helper.renderHtmlToString(post.content),
                      style: TextStyle(
                        fontSize: p2,
                        fontWeight: regular
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
