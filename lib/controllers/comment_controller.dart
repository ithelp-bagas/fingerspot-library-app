// ignore_for_file: unused_import

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fingerspot_library_app/controllers/auth_controller.dart';
import 'package:fingerspot_library_app/helpers/api.dart';
import 'package:fingerspot_library_app/models/comment_model.dart';
import 'package:fingerspot_library_app/routes/app_routes.dart';
import 'package:get/get.dart';

class CommentController extends GetxController {
  final AuthController authController = Get.put(AuthController());
  RxMap<int, bool> isTappedChild = <int, bool>{}.obs;
  Dio dio = Dio();
  RxList<Comment> commentList = RxList<Comment>([]);

  Future<void> toggleReply(int commentId) async {
    try {
      isTappedChild[commentId] = !(isTappedChild[commentId] ?? false);
      var response = await dio.post(
        '${Api.baseUrl}/post/getChildComment',
        data: {
          'comment_id' : commentId
        },
        options: Options(
            headers: {
              "Authorization": "Bearer ${authController.userAuth.value!.token}"
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
}