import 'package:fingerspot_library_app/controllers/auth_controller.dart';
import 'package:fingerspot_library_app/controllers/post_controller.dart';
import 'package:fingerspot_library_app/helpers/shared_pref.dart';
import 'package:fingerspot_library_app/models/auth_model.dart';
import 'package:fingerspot_library_app/routes/app_routes.dart';
import 'package:fingerspot_library_app/views/components/card_categories.dart';
import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:fingerspot_library_app/views/screens/home/components/card_diskusi.dart';
import 'package:fingerspot_library_app/views/screens/home/components/shimmer_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final AuthController authController = Get.put(AuthController());
  final PostController postController = Get.put(PostController());
  RxString officeName = ''.obs;

  Future<bool> cekToken() async{
    String? token = await SharedPref().getToken();
    if(token != null) {
      return true;
    }
    return false;
  }

  Future<void> getData() async{
    await postController.getCategory();
    await postController.getPost(postController.selectedCategoryId.value);
    officeName.value = (await SharedPref().getOfficeName())!;
  }



  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (builder, snapshot) {
        if(snapshot.hasError) {
          Future.microtask(() => Get.toNamed(Routes.ERROR, arguments: {'title': 'Masuk untuk melihat semua fitur'}));
          return Container();
        } else if(snapshot.connectionState == ConnectionState.waiting) {
          return const ShimmerHomeScreen();
        } else {
          return FutureBuilder<bool>(
            future: cekToken(),
            builder: (context, tokenSnapshot) {
              if (tokenSnapshot.connectionState == ConnectionState.waiting) {
                return const ShimmerHomeScreen();
              }
              if (tokenSnapshot.data == true) {
                return RefreshIndicator(
                  onRefresh: () async {
                    await postController.getPost(postController.selectedCategoryId.value);
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.h),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor, // Make sure to define Theme.of(context).primaryColor somewhere in your code
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Image.asset("assets/icons/company.png"),
                              ),
                              Expanded(
                                flex: 7,
                                child: Text(
                                  officeName.value ?? '',
                                  // '',
                                  style: TextStyle(
                                    color: kLight, // Make sure to define kLight somewhere in your code
                                    fontSize: 16.sp, // Adjust font size with ScreenUtil
                                    fontWeight: FontWeight.w700,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Obx(() {
                          final categoryList = postController.categoryList;
                          return SizedBox(
                            height: 50.0, // Adjust height as needed
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: categoryList.length,
                              itemBuilder: (context, index) {
                                final category = categoryList[index];
                                return Obx(() => GestureDetector(
                                    onTap: () async {
                                      await postController.tappedCategory(category.id);
                                    },
                                    child: CardCategories(
                                      categoriesName: '${category.name}${category.postsCount > 0 ? ' (${category.postsCount})' : ''}',
                                      isSelected: postController.selectedCategoryId.value == category.id,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                        Obx(() {
                          final postList = postController.postList;
                          if (postController.isLoading.value) {
                            return const ShimmerHomeScreen();
                          } else {
                            if (postList.isEmpty) {
                              return RefreshIndicator(
                                onRefresh: () async {
                                  await postController.getPost(postController.selectedCategoryId.value);
                                },
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height * .7,
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset('assets/images/no_data.png', width: 100.h),
                                        Text(
                                          'Tidak ada data ditemukan',
                                          style: TextStyle(
                                            fontSize: 16.sp, // Adjust font size with ScreenUtil
                                            fontWeight: FontWeight.bold, // Replace with your preferred weight
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: postList.length,
                                itemBuilder: (context, index) {
                                  final post = postList[index];
                                  return CardDiskusi(
                                    nameUser: '${post.user.firstname} ${post.user.lastname}',
                                    title: post.title,
                                    content: post.content,
                                    like: post.postLike.toString(),
                                    comment: post.postComment,
                                    view: post.views.toString(),
                                    date: post.createdAt,
                                    imagePath: post.user.image,
                                    postId: post.id,
                                    index: index,
                                    userId: post.userId,
                                  );
                                },
                              );
                            }
                          }
                        }),
                      ],
                    ),
                  ),
                );
              } else {
                Future.microtask(() => Get.toNamed(Routes.ERROR, arguments: {'title': 'Masuk untuk melihat semua fitur'}));
                return Container(); // Return an empty container or other appropriate placeholder
              }
            },
          );

        }
      },
    );
  }
}
