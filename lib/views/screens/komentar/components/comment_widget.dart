import 'package:fingerspot_library_app/models/comment_model.dart';
import 'package:fingerspot_library_app/views/screens/komentar/card_single_comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({super.key, required this.comment, required this.isTappedChild, required this.allComments, required this.onTapReply, required this.postUserId});
  final Comment comment;
  final Map<int, bool> isTappedChild;
  final List<Comment> allComments;
  final Function(int) onTapReply;
  final int postUserId;

  @override
  Widget build(BuildContext context) {
    final childComments = allComments.where((c) => c.parentCommentId == comment.id).toList();

    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardSingleComment(
            imgPath: comment.user.image,
            name: '${comment.user.firstname} ${comment.user.lastname}',
            date: comment.createdAt,
            komentar: comment.comment,
            like: comment.commentLike,
            balasan: comment.countReplies,
            liked: comment.liked,
            commentId: comment.id,
            commentUserId: comment.userId,
            postUserId: postUserId,
            postId: comment.postId,
          ),
          if (isTappedChild[comment.id] == true)
            Container(
              margin: EdgeInsets.only(left: 15.h),
              // padding: EdgeInsets.only(left: 15.h), // Indentation for child comments
              child: Column(
                children: childComments.map((childComment) {
                  return CommentWidget(
                    comment: childComment,
                    isTappedChild: isTappedChild,
                    allComments: allComments,
                    onTapReply: onTapReply,
                    postUserId: postUserId,
                  );
                }).toList(),
              ),
            ),
        ],
      );
    });
  }
}
