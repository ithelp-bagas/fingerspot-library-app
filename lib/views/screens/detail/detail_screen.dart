import 'package:cached_network_image/cached_network_image.dart';
import 'package:fingerspot_library_app/controllers/post_controller.dart';
import 'package:fingerspot_library_app/helpers/api.dart';
import 'package:fingerspot_library_app/helpers/helpers.dart';
import 'package:fingerspot_library_app/routes/app_routes.dart';
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
    int postId = params['postId'] ?? 0;
    String imgPath = params['imgPath'] ?? '';
    return Obx(() {
      return FutureBuilder(
          future: _fetchPostDetails(postId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator()); // Show loading indicator
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}')); // Show error message
            } else {
              var post = postController.detailPost.value;
              if (post == null) {
                return const Center(child: Text('No data available')); // Show message if no data
              }
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Diskusi'),
                  centerTitle: true,
                ),
                bottomNavigationBar: BottomAppBar(
                  shape: const CircularNotchedRectangle(),
                  notchMargin: 8.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Obx(() {
                          var post = postController.detailPost.value;
                          return Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  post!.liked ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                                  color: post.liked ? kPrimary : kGrey,
                                ),
                                onPressed: () async {
                                  await postController.likePost(postId, true, true);
                                },
                              ),
                              Text('${post.postLike}')
                            ],
                          );
                        }),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.message),
                              onPressed: () {
                                Get.toNamed(Routes.KOMENTAR, arguments: {
                                  'komentar': post.postComment,
                                  'postId': post.id,
                                });
                              },
                            ),
                            Text('${post.postComment}')
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.bookmark_outline ),
                              onPressed: () {
                                // Handle bookmark action
                              },
                            ),
                            const Text('Simpan')
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Padding(
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
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          }
      );
    });
  }
}
