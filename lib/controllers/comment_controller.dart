// ignore_for_file: unused_import

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fingerspot_library_app/controllers/auth_controller.dart';
import 'package:fingerspot_library_app/controllers/post_controller.dart';
import 'package:fingerspot_library_app/helpers/api.dart';
import 'package:fingerspot_library_app/helpers/shared_pref.dart';
import 'package:fingerspot_library_app/models/comment_model.dart';
import 'package:fingerspot_library_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentController extends GetxController {
  final AuthController authController = Get.put(AuthController());
  final PostController postController = Get.put(PostController());
  RxMap<int, bool> isTappedChild = <int, bool>{}.obs;
  Dio dio = Dio();
  RxList<Comment> commentList = RxList<Comment>([]);
  RxBool repliedTap = false.obs;
  RxString imgPathUser = ''.obs;
  RxString nameUser = ''.obs;
  RxString commentUser = ''.obs;
  RxInt commentIdUser = 0.obs;
  RxBool isLoading = false.obs;

  String? token;

  Future<void> getToken() async {
    token = await SharedPref().getToken();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getToken();
  }


  void toggleUserCommentReply(String imgPath, String name, String comment, int commentId) {
    repliedTap.value = !repliedTap.value;
    if (repliedTap.value) {
      imgPathUser.value = imgPath;
      nameUser.value = name;
      commentUser.value = comment;
      commentIdUser.value = commentId;
    } else {
      imgPathUser.value = '';
      nameUser.value = '';
      commentUser.value = '';
      commentIdUser.value = 0;
    }
  }


  Future<void> toggleReply(int commentId) async {
    try {
      isTappedChild[commentId] = !(isTappedChild[commentId] ?? false);
      var response = await dio.post(
        '${Api.baseUrl}/comment/getChildComment',
        data: {
          'comment_id' : commentId
        },
        options: Options(
            headers: {
              "Authorization": "Bearer $token"
            }
        ),
      );
      if(response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        List<dynamic> data = responseData['data'];
        commentList.value = data.map((json) => Comment.fromJson(json)).toList();

      } else {
        Get.toNamed(Routes.ERROR, arguments: {'title': 'Coming Soon'});
        throw Exception('error');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> replyComment(String comment, int commentId, int postId, int commentCount) async {
    try {
      postController.isLoading.value = true;
      var response = await dio.post(
        '${Api.baseUrl}/comment/comment-reply',
        data: {
          'comment_id': commentId,
          'post_id': postId,
          'comment': comment
        },
        options: Options(
            headers: {
              "Authorization": "Bearer $token"
            }
        ),
      );

      if(response.statusCode == 200) {
        await postController.getDetailPost(postId);
        postController.detailPost.refresh();
        Get.offNamed(Routes.KOMENTAR, arguments: {'komentar': commentCount, 'postId': postId});
        postController.komentarController.clear();
      } else {
        Get.toNamed(Routes.ERROR, arguments: {'title': 'Coming Soon'});
        throw Exception('Error');
      }
    } catch (e) {
      throw Exception(e);
    } finally {
      FocusScope.of(Get.context!).unfocus();
      postController.isLoading.value = false;
      repliedTap.value = false;
    }
  }

  Future<void> likeComment(int commentId, int postId) async {
    try {
      var response = await dio.post(
        '${Api.baseUrl}/comment/comment-like',
        data: {
          'comment_id': commentId,
          'vote': 1
        },
        options: Options(
            headers: {
              "Authorization": "Bearer $token"
            }
        ),
      );

      if(response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        var data = responseData['data']['likeCount'];
        int commentIndex = commentList.indexWhere((comment) => comment.id == commentId);
        postController.getDetailPost(postId);
        if(commentIndex != -1) {
          commentList[commentIndex].liked = !commentList[commentIndex].liked;
          commentList[commentIndex].commentLike = data;
          commentList.refresh();
        }
      } else {
        Get.toNamed(Routes.ERROR, arguments: {'title': 'Coming Soon'});
        throw Exception('error');
      }
    } catch(e) {
      throw Exception(e);
    }
  }
}