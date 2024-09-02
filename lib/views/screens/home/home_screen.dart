import 'package:fingerspot_library_app/controllers/post_controller.dart';
import 'package:fingerspot_library_app/views/components/card_categories.dart';
import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:fingerspot_library_app/views/screens/home/components/card_diskusi.dart';
import 'package:fingerspot_library_app/views/screens/home/components/shimmer_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final PostController postController = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10.h),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: kPrimary, // Make sure to define kPrimary somewhere in your code
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
                    "PT. Maju Jaya (Maju Kinerja Bandung)",
                    style: TextStyle(
                      color: kLight, // Make sure to define kLight somewhere in your code
                      fontSize: 16.sp, // Adjust font size with ScreenUtil
                      fontWeight: FontWeight.w700,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: Icon(
                    Icons.work,
                    color: kSuccess, // Make sure to define kSuccess somewhere in your code
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: kLight, // Make sure to define kLight somewhere in your code
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
                  return GestureDetector(
                    onTap: () async {
                      await postController.tappedCategory(category.id);
                    },
                    child: Obx(() => CardCategories(
                      categoriesName: '${category.name}${category.postsCount > 0 ? ' (${category.postsCount})' : ''}',
                      isSelected: postController.selectedCategoryId.value == category.id,
                    )),
                  );
                },
              ),
            );
          }),
          Obx(() {
            final postList = postController.postList;
            if (postController.isLoading.value) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * .7,
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const ShimmerCard(); // Ensure ShimmerCard is properly defined
                  },
                ),
              );
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
                            'Belum ada data',
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
                return RefreshIndicator(
                  onRefresh: () async {
                    await postController.getPost(postController.selectedCategoryId.value);
                  },
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * .7,
                    child: ListView.builder(
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
                        );
                      },
                    ),
                  ),
                );
              }
            }
          }),
        ],
      ),
    );
  }
}
