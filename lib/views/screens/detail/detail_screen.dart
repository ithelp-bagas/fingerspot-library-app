import 'package:cached_network_image/cached_network_image.dart';
import 'package:fingerspot_library_app/controllers/post_controller.dart';
import 'package:fingerspot_library_app/helpers/api.dart';
import 'package:fingerspot_library_app/helpers/helpers.dart';
import 'package:fingerspot_library_app/routes/app_routes.dart';
import 'package:fingerspot_library_app/views/components/card_tags.dart';
import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shimmer/shimmer.dart';

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
            return _buildShimmer();
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            var post = postController.detailPost.value;
            if (post == null) {
              return const Center(child: Text('No data available'));
            }
            return Scaffold(
              appBar: AppBar(
                title: const Text('Diskusi'),
                centerTitle: true,
              ),
              bottomNavigationBar: BottomAppBar(
                shape: const CircularNotchedRectangle(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Obx(() {
                      var post = postController.detailPost.value;
                      return Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              post!.liked ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                              color: post.liked ? kPrimary : Theme.of(context).iconTheme.color,
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
                    Obx(() {
                      var post = postController.detailPost.value;
                      return Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              post!.saved ? Icons.bookmark : Icons.bookmark_add_outlined,
                              color:  post.saved ? kPrimary : Theme.of(context).iconTheme.color,
                            ),
                            onPressed: () async{
                              await postController.addBookmark(postId);
                            },
                          ),
                          Text(
                            post.saved ? 'Disimpan' : 'Simpan',
                          )
                        ],
                      );
                    }),
                  ],
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
                          SizedBox(width: 10.h),
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
                                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
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
                            child: Row(
                              children: [
                                Icon(MdiIcons.chat, color: kPrimary,),
                                SizedBox(width: 5.w,),
                                Text(
                                  "Topik ${post.categoryName}",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: kPrimary,
                                    fontSize: p2,
                                    fontWeight: regular,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: PopupMenuButton(
                              itemBuilder:  (context) => [
                                PopupMenuItem(
                                  onTap: () {
                                    Get.dialog(
                                      Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Material(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min, // This makes the dialog take only as much space as needed
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(height: 10),
                                                Center(
                                                  child: Text(
                                                    "Laporkan",
                                                    style: TextStyle(
                                                      fontSize: p1,
                                                      fontWeight: heavy,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                SizedBox(height: 10.h),
                                                Text(
                                                  "Alasan : ",
                                                  style: TextStyle(
                                                    fontSize: p2,
                                                    fontWeight: regular,
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                                SizedBox(height: 10.h),
                                                TextFormField(
                                                  controller: postController.reasonController,
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(10.h),
                                                    ),
                                                  ),
                                                  minLines: 3,
                                                  keyboardType: TextInputType.multiline,
                                                  maxLines: null,
                                                ),
                                                const SizedBox(height: 20),
                                                //Buttons
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Obx(
                                                          () => Expanded(
                                                        child: Text(
                                                          '${postController.charCount.value}/300',
                                                          style: TextStyle(
                                                            fontSize: p3,
                                                            fontWeight: regular,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Expanded(
                                                      child: Obx(
                                                            () => ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                            foregroundColor: kLight,
                                                            backgroundColor: postController.charCount.value < 1 ? kGrey : kPrimary,
                                                            minimumSize: const Size(0, 45),
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(8),
                                                            ),
                                                          ),
                                                          onPressed: postController.charCount.value < 1
                                                              ? () {}
                                                              : () async {
                                                            if (!postController.isLoading.value) {
                                                              postController.isLoading.value = true;

                                                              // Execute the report function
                                                              await postController.reportPost(postId, postController.reasonController.text);

                                                              // Reset loading state
                                                              postController.isLoading.value = false;

                                                              // Clear the controller and reset the count
                                                              postController.reasonController.clear();
                                                              postController.charCount.value = 0;
                                                            }
                                                          },
                                                          child: postController.isLoading.value
                                                              ? const CircularProgressIndicator()
                                                              : const Text('KIRIM'),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(Icons.report_outlined),
                                      SizedBox(width: 5.w,),
                                      Text(
                                        'Laporkan',
                                        style: TextStyle(
                                            fontSize: smLabel,
                                            fontWeight: regular
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  onTap: (){
                                    postController.copyLink(Api.defaultUrl + post.link);
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(Icons.link_rounded),
                                      SizedBox(width: 5.w,),
                                      Text(
                                        'Salin Tautan',
                                        style: TextStyle(
                                            fontSize: smLabel,
                                            fontWeight: regular
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        post.title,
                        style: TextStyle(
                          fontSize: p1,
                          fontWeight: heavy,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        helper.renderHtmlToString(post.content),
                        style: TextStyle(
                          fontSize: p2,
                          fontWeight: regular,
                        ),
                      ),
                      SizedBox(height: 30.h),
                      post.tags.isEmpty
                          ? Container()
                          : Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: [
                          for (var item in post.tags)
                            CardTags(tagsName: item.name),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Icon(
                              FluentIcons.person_note_16_filled,
                              color: Theme.of(context).iconTheme.color
                          ),
                          SizedBox(width: 5.h),
                          Text(
                            'Diposting pada tanggal ${helper.formatedDateWtime(post.createdAt)}',
                            style: TextStyle(
                              fontSize: p2,
                              fontWeight: regular,
                              color: Theme.of(context).textTheme.labelSmall?.color,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      );
    });
  }
}

Widget _buildShimmer() {
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
            _buildShimmerItem(),
            _buildShimmerItem(),
            _buildShimmerItem(),
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
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 28.h,
                      height: 28.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.h),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.h),
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: double.infinity,
                          height: 16.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: double.infinity,
                          height: 14.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: double.infinity,
                      height: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: Icon(
                    Icons.more_vert,
                    color: Colors.transparent,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: double.infinity,
                height: 20.0,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10.h),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: double.infinity,
                height: 100.0,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 30.h),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: List.generate(3, (index) => Container(
                  width: 100.0,
                  height: 20.0,
                  color: Colors.white,
                )),
              ),
            ),
            SizedBox(height: 10.h),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 150.0,
                height: 16.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildShimmerItem() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Row(
      children: [
        Container(
          width: 40.h,
          height: 40.h,
          color: Colors.white,
        ),
        const SizedBox(width: 10.0),
        Container(
          width: 10.h,
          height: 16.h,
          color: Colors.white,
        ),
      ],
    ),
  );
}


