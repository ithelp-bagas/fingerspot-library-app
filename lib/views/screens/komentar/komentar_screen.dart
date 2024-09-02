import 'package:fingerspot_library_app/controllers/comment_controller.dart';
import 'package:fingerspot_library_app/controllers/post_controller.dart';
import 'package:fingerspot_library_app/helpers/helpers.dart';
import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:fingerspot_library_app/views/screens/komentar/components/card_comment_replies.dart';
import 'package:fingerspot_library_app/views/screens/komentar/components/comment_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class KomentarScreen extends StatelessWidget {
  KomentarScreen({super.key});
  final PostController postController = Get.put(PostController());
  final CommentController commentController = Get.put(CommentController());
  Helper helper = Helper();

  Future<void> _loadData(int postId) async {
    await postController.getDetailPost(postId);
  }

  @override
  Widget build(BuildContext context) {
    var args = Get.arguments;
    var komentar = args['komentar'];
    var postId = args['postId'];

    // Refresh the data when the screen is loaded
    postController.getDetailPost(postId);

    return Scaffold(
      appBar: AppBar(
        title: Text("Komentar ($komentar)"),
        centerTitle: true,
      ),
      body: Obx(() {
        var post = postController.detailPost.value;

        if (post == null) {
          return _buildShimmer();
        }

        if (post.comments.isEmpty) {
          return RefreshIndicator(
            onRefresh: () async {
              await postController.getDetailPost(postId);
            },
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(30.h),
                    child: Image.asset('assets/images/no_data.png', width: 100.h),
                  ),
                  Text(
                    'Belum ada Komentar',
                    style: TextStyle(
                      fontSize: defLabel,
                      fontWeight: heavy,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 60.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Add a comment...',
                              contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                            ),
                            controller: postController.komentarController,
                          ),
                        ),
                        Obx(() {
                          var isLoading = postController.isLoading;
                          if (isLoading.value) {
                            return const CircularProgressIndicator();
                          } else {
                            return IconButton(
                              onPressed: () async {
                                if (postController.komentarController.text == '') {
                                  Get.snackbar('Warning', 'Komentar harus diisi!', backgroundColor: kWarning);
                                } else {
                                  await postController.comment(postId, postController.komentarController.text, komentar);
                                  postController.komentarController.clear();
                                  Get.snackbar('Success', 'Berhasil menambahkan komentar!', backgroundColor: kSuccess);
                                }
                              },
                              icon: const Icon(Icons.send, color: kPrimary),
                            );
                          }
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: () async {
            await _loadData(postId);
          },
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: post.comments.where((comment) => comment.parentCommentId == 0).length,
                  itemBuilder: (context, index) {
                    final filteredComments = post.comments.where((comment) => comment.parentCommentId == 0).toList();
                    final comment = filteredComments[index];
                    return CommentWidget(
                      comment: comment,
                      isTappedChild: commentController.isTappedChild,
                      allComments: post.comments,
                      onTapReply: (commentId) async {
                        await commentController.toggleReply(commentId);
                      },
                      postUserId: post.userId,
                    );
                  },
                ),
              ),
              commentController.repliedTap.value ? CardCommentReplies(imgPath: commentController.imgPathUser.value, name: commentController.nameUser.value, comment: commentController.commentUser.value)
              : Container(),
              Container(
                height: 60.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: postController.komentarController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Add a comment...',
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Obx(() {
                        var isLoading = postController.isLoading;
                        if (isLoading.value) {
                          return const CircularProgressIndicator();
                        } else {
                          return IconButton(
                            onPressed: () async {
                              if (postController.komentarController.text == '') {
                                Get.snackbar('Warning', 'Komentar harus diisi!', backgroundColor: kWarning);
                              } else {
                                if(commentController.repliedTap.value) {
                                  await commentController.replyComment(postController.komentarController.text, commentController.commentIdUser.value, postId, komentar);
                                } else {
                                  await postController.comment(postId, postController.komentarController.text, komentar);
                                }
                                Get.snackbar('Success', 'Berhasil menambahkan komentar!', backgroundColor: kSuccess);
                              }
                            },
                            icon: const Icon(Icons.send, color: kPrimary),
                          );
                        }
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 10, // Adjust based on the expected number of items
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 24,
                ),
                title: Container(
                  color: Colors.grey,
                  height: 10,
                  width: double.infinity,
                ),
                subtitle: Container(
                  color: Colors.grey,
                  height: 10,
                  width: double.infinity,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}