import 'package:cached_network_image/cached_network_image.dart';
import 'package:fingerspot_library_app/controllers/comment_controller.dart';
import 'package:fingerspot_library_app/controllers/post_controller.dart';
import 'package:fingerspot_library_app/helpers/api.dart';
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
    postController.getAllUser();
    postController.komentarController.clear();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Komentar ($komentar)",
          style: TextStyle(
            fontSize: h4,
            fontWeight: heavy
          )
        ),
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
            child: LayoutBuilder( // Add LayoutBuilder to get the available constraints
              builder: (context, constraints) {
                return SingleChildScrollView( // Enable scrolling when content exceeds the view
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: ConstrainedBox( // Ensure that the content takes up the available height
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight( // Let the Column take up as much space as it needs
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
                          Obx(() {
                            final userList = postController.searchUser;
                            return postController.isMention.value // Show user list when mention is active
                                ? Container(
                              height: 200.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: ListView.builder(
                                itemCount: userList.length,
                                itemBuilder: (context, index) {
                                  final user = userList[index];
                                  return ListTile(
                                    leading: CircleAvatar(
                                      radius: 18.h, // Adjust the size as needed
                                      backgroundImage: CachedNetworkImageProvider(Api.imgurl + user.image),
                                      backgroundColor: Colors.transparent,
                                      child: CachedNetworkImage(
                                        imageUrl: Api.imgurl + user.image,
                                        imageBuilder: (context, imageProvider) => CircleAvatar(
                                          radius: 18.h,
                                          backgroundImage: imageProvider,
                                        ),
                                        errorWidget: (context, url, error) =>  CircleAvatar(
                                          radius: 18.h,
                                          backgroundImage: AssetImage('assets/images/profile.jpg'),
                                        ),
                                      ),
                                    ),

                                    title: Text(user.username),
                                    subtitle: Text('${user.firstname} ${user.lastname}'),
                                    onTap: () {
                                      // Insert selected username in the comment field
                                      final currentText = postController.komentarController.text;
                                      final newText = currentText.replaceAll(
                                          RegExp(r"@\w*$"), "@${user.username} "); // Replace '@' with the selected username
                                      postController.komentarController.text = newText;
                                      postController.komentarController.selection = TextSelection.fromPosition(
                                        TextPosition(offset: postController.komentarController.text.length),
                                      );
                                      postController.isMention.value = false; // Hide the user list after selection
                                    },
                                  );
                                },
                              ),
                            )
                                : const SizedBox.shrink(); // Hide if no users to mention
                          }),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0), // Add padding for comment section
                            child: Container(
                              height: 60.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.grey[200], // Optional background color
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
                                      onChanged: (value) {
                                        postController.searchText.value = value;

                                        // Check if the last character is '@'
                                        if (value.isNotEmpty && value[value.length - 1] == '@') {
                                          postController.isMention.value = true; // Show the user list
                                        } else {
                                          postController.isMention.value = false; // Hide the user list
                                        }

                                        // Perform the search for user mention if '@' is present
                                        if (value.contains('@')) {
                                          String mentionQuery = value.split('@').last.trim(); // Extract the query after '@'
                                          postController.searchUserMention(mentionQuery); // Perform search
                                        }
                                      },
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
                                            Get.snackbar('Success', 'Berhasil menambahkan komentar!', backgroundColor: kSuccess, colorText: kLight);
                                          }
                                        },
                                        icon: Icon(Icons.send, color: Theme.of(context).primaryColor),
                                      );
                                    }
                                  }),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: () async {
            await _loadData(postId);
          },
          child: Obx(() => Column(
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
                        index: index,
                      );
                    },
                  ),
                ),
                commentController.repliedTap.value ? CardCommentReplies(imgPath: commentController.imgPathUser.value, name: commentController.nameUser.value, comment: commentController.commentUser.value)
                : Container(),
                Obx(() {
                  final userList = postController.searchUser;
                  return postController.isMention.value // Show user list when mention is active
                      ? Container(
                    height: 200.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (context, index) {
                        final user = userList[index];
                        return ListTile(
                          leading: CircleAvatar(
                            radius: 18.h, // Adjust the size as needed
                            backgroundImage: CachedNetworkImageProvider(Api.imgurl + user.image),
                            backgroundColor: Colors.transparent,
                            child: CachedNetworkImage(
                              imageUrl: Api.imgurl + user.image,
                              imageBuilder: (context, imageProvider) => CircleAvatar(
                                radius: 18.h,
                                backgroundImage: imageProvider,
                              ),
                              errorWidget: (context, url, error) =>  CircleAvatar(
                                radius: 18.h,
                                backgroundImage: AssetImage('assets/images/profile.jpg'),
                              ),
                            ),
                          ),

                          title: Text(user.username),
                          subtitle: Text('${user.firstname} ${user.lastname}'),
                          onTap: () {
                            // Insert selected username in the comment field
                            final currentText = postController.komentarController.text;
                            final newText = currentText.replaceAll(
                                RegExp(r"@\w*$"), "@${user.username} "); // Replace '@' with the selected username
                            postController.komentarController.text = newText;
                            postController.komentarController.selection = TextSelection.fromPosition(
                              TextPosition(offset: postController.komentarController.text.length),
                            );
                            postController.isMention.value = false; // Hide the user list after selection
                          },
                        );
                      },
                    ),
                  )
                      : const SizedBox.shrink(); // Hide if no users to mention
                }),
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
                          onChanged: (value) {
                            postController.searchText.value = value;

                            // Check if the last character is '@'
                            if (value.isNotEmpty && value[value.length - 1] == '@') {
                              postController.isMention.value = true; // Show the user list
                            } else {
                              postController.isMention.value = false; // Hide the user list
                            }

                            // Perform the search for user mention if '@' is present
                            if (value.contains('@')) {
                              String mentionQuery = value.split('@').last.trim(); // Extract the query after '@'
                              postController.searchUserMention(mentionQuery); // Perform search
                            }
                          },
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
                                  Get.snackbar('Success', 'Berhasil menambahkan komentar!', backgroundColor: kSuccess, colorText: kLight);
                                }
                              },
                              icon: Icon(Icons.send, color: Theme.of(context).primaryColor),
                            );
                          }
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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