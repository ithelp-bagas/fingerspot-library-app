import 'package:fingerspot_library_app/controllers/post_controller.dart';
import 'package:fingerspot_library_app/routes/app_routes.dart';
import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:fingerspot_library_app/views/screens/disimpan/components/card_disimpan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class DisimpanScreen extends StatelessWidget {
  DisimpanScreen({super.key});

  final PostController postController = Get.put(PostController());

  Future<void> _getBookmarkData() async {
    await postController.getBookmarkPost();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getBookmarkData(),
      builder: (builder, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildShimmer(context);
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final bookmarkList = postController.bookmarkPostList;
          if(postController.bookmarkPostList.isEmpty) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/no_data.png', width: 100.h,),
                  Text(
                    'Belum ada postingan yang disimpan',
                    style: TextStyle(
                        fontSize: defLabel,
                        fontWeight: heavy
                    ),
                  )
                ],
              ),
            );
          }
          return Obx(() => RefreshIndicator(
            onRefresh: _getBookmarkData,
            child: Padding(
              padding: EdgeInsets.all(10.h),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * .9,
                child: ListView.builder(
                  itemCount: bookmarkList.length,
                  itemBuilder: (builder, index){
                    final bookmark = bookmarkList[index];
                    if(bookmarkList.isEmpty) {
                      return Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/no_data.png', width: 100.h,),
                            Text(
                              'Belum ada postingan yang disimpan',
                              style: TextStyle(
                                  fontSize: defLabel,
                                  fontWeight: heavy
                              ),
                            )
                          ],
                        ),
                      );
                    } else {
                      return GestureDetector(
                        onTap: () => Get.toNamed(Routes.DETAIL, arguments: {'postId': bookmark.id, 'imgPath': bookmark.user.image, 'liked': bookmark.liked}),
                        child: CardDisimpan(
                            postId: bookmark.id,
                            nameUser: '${bookmark.user.firstname} ${bookmark.user.lastname}',
                            imgPath: bookmark.user.image,
                            date: bookmark.createdAt,
                            categoryName: bookmark.categoryName,
                            title: bookmark.title,
                            index: index,
                            userId: bookmark.userId,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
          );
        }
      },
    );
  }
}

Widget _buildShimmer (BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 1,
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
