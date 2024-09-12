import 'package:fingerspot_library_app/controllers/post_controller.dart';
import 'package:fingerspot_library_app/controllers/profile_controller.dart';
import 'package:fingerspot_library_app/routes/app_routes.dart';
import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:fingerspot_library_app/views/screens/default_screen.dart';
import 'package:fingerspot_library_app/views/screens/profile/components/card_profile.dart';
import 'package:fingerspot_library_app/views/screens/profile/components/section_user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final ProfileController profileController = Get.put(ProfileController());
  final PostController postController = Get.put(PostController());

  Future<void> getData() async {
    await profileController.getProfile(0);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const DefaultScreen(); // Handle errors properly
        } else {
          final user = profileController.profileDetail.value!;
          return RefreshIndicator(
            onRefresh: getData,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionUserInfo(
                      activityPoint: user.credit,
                      totalPost: user.postTotal,
                      totalTopics: user.topicTotal,
                      name: '${user.firstname} ${user.lastname}',
                      email: user.email,
                      officeName: user.officeName,
                      department: user.departmentName,
                      role: user.roleName,
                      imgPath: user.image,
                    ),
                    const Divider(),
                    Center(
                      child: Text(
                        'My Post',
                        style: TextStyle(
                          fontSize: smLabel,
                          fontWeight: medium,
                        ),
                      ),
                    ),
                    const Divider(),
                    Obx(() {
                      final postList = postController.profilePostList;
                      if (postList.isEmpty) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * .5,
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/no_data.png', width: 100.h,),
                                Text(
                                  'Belum ada postingan',
                                  style: TextStyle(
                                      fontSize: defLabel,
                                      fontWeight: heavy
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: postList.length,
                          itemBuilder: (context, index) {
                            final post = postList[index];
                            return GestureDetector(
                              onTap: () => Get.toNamed(Routes.DETAIL, arguments: {'postId': post.id, 'imgPath' : user.image}),
                              child: CardProfile(
                                  imgPath: user.image,
                                  name: '${user.firstname} ${user.lastname}',
                                  date: post.createdAt,
                                  categoryName: post.categoryName,
                                  title: post.title,
                                  content: post.content,
                                  like: post.postLike,
                                  comment: post.postComment,
                                  view: post.views,
                                  index: index,
                                  postId: post.id,
                                  postController: postController,
                                  userId: post.userId,
                              ),
                            ); // Pass post to CardProfile
                          },
                        );
                      }
                    }),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}


