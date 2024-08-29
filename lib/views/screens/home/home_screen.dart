import 'package:fingerspot_library_app/controllers/auth_controller.dart';
import 'package:fingerspot_library_app/controllers/post_controller.dart';
import 'package:fingerspot_library_app/helpers/api.dart';
import 'package:fingerspot_library_app/models/auth_model.dart';
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
            padding: EdgeInsets.all(16.h),
            width: MediaQuery.of(context).size.width * 1,
            decoration: const BoxDecoration(
                color: kPrimary
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
                        color: kLight,
                        fontSize: p1,
                        fontWeight: FontWeight.w700
                    ),
                    overflow: TextOverflow.ellipsis ,
                  ),
                ),
                const Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.work,
                      color: kSuccess,
                    )
                ),
                const Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: kLight,
                    )
                ),
              ],
            ),
          ),
          Obx(() {
            final catgoryList = postController.categoryList;
            return Container(
              height: 40.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: catgoryList.length,
                itemBuilder: (context, index) {
                  final category = catgoryList[index];
                  return GestureDetector(
                    onTap: () async{
                      await postController.tappedCategory(category.id);
                    },
                    child: Obx(() =>
                      CardCategories(
                        categoriesName: '${category.name} (${category.postsCount})',
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
            if(postController.isLoading.value) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * .7,
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const ShimmerCard();
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
                        Image.asset('assets/images/no_data.png', width: 100.h,),
                        Text(
                          'Belum ada data',
                          style: TextStyle(
                              fontSize: defLabel,
                              fontWeight: heavy
                          ),
                        )
                      ],
                    ),
                  )),
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
                        comment: post.postComment.toString(),
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
