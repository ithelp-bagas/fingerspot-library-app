import 'package:fingerspot_library_app/controllers/post_controller.dart';
import 'package:fingerspot_library_app/helpers/api.dart';
import 'package:fingerspot_library_app/routes/app_routes.dart';
import 'package:fingerspot_library_app/views/components/card_categories.dart';
import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:fingerspot_library_app/views/screens/search/components/card_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import 'components/icon_search.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  final PostController postController = Get.put(PostController());

  Future<void> _getSearchData(int searchCategoryId) async {
    await postController.getSearchPost(searchCategoryId);
  }

  @override
  Widget build(BuildContext context) {
    postController.getSearchPost(1);
    return Obx(() => FutureBuilder(
        future: _getSearchData(postController.selectedSearchId.value),
        builder: (builder, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildShimmer(context);
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Padding(
              padding: EdgeInsets.all(10.h),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: postController.searchController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.h)
                        ),
                        prefixIcon: GestureDetector(
                          onTap: (){},
                          child: const Icon(Icons.search),
                        ),
                      ),
                      onChanged: (value) {
                        postController.searchingPost(value);
                      },
                    ),
                    SizedBox(height: 5.h,),
                    Obx(() {
                      final searchList = postController.searchList;
                      return SizedBox(
                        height: 50.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: searchList.length,
                          itemBuilder: (context, index) {
                            final searchCategory = searchList[index];
                            return GestureDetector(
                              onTap: () async{
                                await postController.tappedSearchCategory(searchCategory['id']);
                              },
                              child: CardCategories(
                                categoriesName: searchCategory['name'],
                                isSelected: postController.selectedSearchId.value == searchCategory['id'],
                              ),
                            );
                          },
                        ),
                      );
                    }),
                    Obx(() {
                      final postList = postController.searchPostList;
                      final recommendedlist = postController.recommendedList;
                      return RefreshIndicator(
                        onRefresh: () async{
                          await postController.getSearchPost(postController.selectedCategoryId.value);
                        } ,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * .69,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: 5,
                                  itemBuilder: (builder, index) {
                                    final post = postList[index];
                                    return GestureDetector(
                                      onTap: (){
                                        Get.toNamed(Routes.DETAIL, arguments: {'postId': post.id, 'imgPath': post.user.image, 'liked': post.liked});
                                      },
                                      child: CardSearch(
                                          index: index+1,
                                          namaUser: '${post.user.firstname} ${post.user.lastname}',
                                          imgPath: post.user.image,
                                          categoryName: post.categoryName,
                                          title: post.title,
                                          date: post.createdAt,
                                          viewed: post.views,
                                          commented: post.postComment,
                                          postId: post.id,
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(height: 10.h,),
                                Text(
                                  "Rekomendasi Informasi Untukmu".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: p1,
                                    fontWeight: heavy,
                                    color: kPrimary,
                                  ),
                                ),
                                SizedBox(height: 10.h,),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: recommendedlist.length,
                                  itemBuilder: (builder, index){
                                    final recommended = recommendedlist[index];
                                    return GestureDetector(
                                      onTap: () => Get.toNamed(Routes.DETAIL, arguments: {'postId': recommended.id, 'imgPath': recommended.user.image, 'liked': recommended.liked}),
                                      child: CardRekomendasi(
                                          imgPath: recommended.user.image,
                                          nameUser: '${recommended.user.firstname} ${recommended.user.lastname}',
                                          categoryName: recommended.categoryName,
                                          title: recommended.title,
                                          viewed: recommended.views,
                                          commented: recommended.postComment,
                                          date: recommended.createdAt,
                                          postId: recommended.id,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
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

Widget _buildShimmer (BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.h),
            height: 40.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.h),
            ),
          ),
        ),
        SizedBox(
          height: 50.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5, // Adjust the number of shimmer items
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.h),
                  height: 100.h,
                  width: 100.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.h),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .7,
          child: ListView.builder(itemCount: 5,itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                padding: EdgeInsets.all(10.h),
                width: MediaQuery.of(context).size.width * 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 30.h,
                            width: 16.h,
                            color: kLight,
                          ),
                        ),
                        SizedBox(width: 5.h,),
                        Expanded(
                          flex: 9,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 1,
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
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.h,),
                                    Expanded(
                                      flex: 6,
                                      child: Container(
                                        height: 16.h,
                                        width: 30.h,
                                        color: kLight,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        height: 16.h,
                                        width: 20.h,
                                        color: kLight,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h,),
                                Container(
                                  height: 16.h,
                                  color: kLight,
                                ),
                                SizedBox(height: 10.h,),
                                Row(
                                  children: [
                                    Container(
                                      height: 16.h,
                                      color: kLight,
                                    ),
                                    Container(
                                      height: 16.h,
                                      color: kLight,
                                    ),
                                    Container(
                                      height: 16.h,
                                      color: kLight,
                                    ),
                                    SizedBox(width: 10.h),
                                    Container(
                                      height: 16.h,
                                      color: kLight,
                                    ),
                                  ],
                                ),
                                const Divider(
                                  color: kGrey,
                                  thickness: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h,),
                    Container(
                      height: 16.h,
                      color: Colors.white,
                    ),
                    SizedBox(height: 10.h,),
                    Container(
                      height: 14.h,
                      color: Colors.white,
                    ),
                    SizedBox(height: 10.h,),
                    Row(
                      children: [
                        Container(
                          width: 50.h,
                          height: 14.h,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10.h,),
                        Container(
                          width: 50.h,
                          height: 14.h,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10.h,),
                        Container(
                          width: 50.h,
                          height: 14.h,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h,),
                    const Divider(
                      color: kGrey,
                      thickness: 1,
                    ),
                  ],
                ),
              ),
            );
          }),
        )
      ],
    ),
  );
}
