import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:fingerspot_library_app/controllers/auth_controller.dart';
import 'package:fingerspot_library_app/helpers/api.dart';
import 'package:fingerspot_library_app/models/category_model.dart';
import 'package:fingerspot_library_app/models/post_model.dart';
import 'package:fingerspot_library_app/models/user_model.dart';
import 'package:fingerspot_library_app/models/votes_model.dart';
import 'package:fingerspot_library_app/routes/app_routes.dart';
import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  final AuthController authController = Get.put(AuthController());
  Dio dio = Dio();
  RxList<Post> postList = RxList<Post>([]);
  RxList<User> viewerPost = RxList<User>([]);
  RxList<Category> categoryList = RxList<Category>([]);
  RxList<Votes> votesList = RxList<Votes>([]);
  RxInt selectedCategoryId = 1.obs;
  var detailPost = Rxn<Post>();
  RxBool isLoading = false.obs;


  @override
  void onInit() async{
    super.onInit();
    await getCategory();
    await getPost(selectedCategoryId.value);
  }

  void setDetail(Post newdetailpost) {
    detailPost.value = newdetailpost;
  }

  Future<void> tappedCategory(int categoryId) async {
    selectedCategoryId.value = categoryId;
    await getPost(categoryId);
  }

  Future<void> getCategory() async {
    try {
      var response = await dio.get(
        '${Api.baseUrl}/post/list-category',
        options: Options(
            headers: {
              "Authorization": "Bearer ${authController.userAuth.value!.token}"
            }
        ),
      );

      if(response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        List<dynamic> data = responseData['data'];
        categoryList.value = data.map((json) => Category.fromJson(json)).toList();
      } else {
        Get.toNamed(Routes.ERROR, arguments: {'title': 'Coming Soon'});
        throw Exception('error');
      }

    } catch(e) {
      throw Exception(e);
    }
  }

  Future<void> getPost(int categoryId) async {
    try{
      isLoading.value = true;
      print(authController.userAuth.value!.token);
      var response = await dio.get(
        '${Api.baseUrl}/post/list-post',
        data: {
          'category_id': categoryId
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
        postList.value = data.map((json) => Post.fromJson(json)).toList();
      } else {
        Get.toNamed(Routes.ERROR, arguments: {'title': 'Coming Soon'});
        throw Exception('error');
      }
    } catch(e) {
      throw Exception(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> likePost(int postId, bool vote, bool isDetail) async{
      try {
        var response = await dio.post(
          '${Api.baseUrl}/post/like',
          data: {
            'post_id': postId,
            'vote': vote ? "1" : "0"
          },
          options: Options(
              headers: {
                "Authorization": "Bearer ${authController.userAuth.value!.token}"
              }
          ),
        );

        if(response.statusCode == 200){
          if(isDetail) {
            Map<String, dynamic> responseData = response.data;
            var data = responseData['data']['total_likes'];
            detailPost.value?.postLike = data;
            detailPost.value?.liked = !detailPost.value!.liked;
            detailPost.refresh();

            int postIndex = postList.indexWhere((post) => post.id == detailPost.value?.id);
            if(postIndex != -1) {
              postList[postIndex].liked = !postList[postIndex].liked;
              postList[postIndex].postLike = data;
              postList.refresh();
            }

          } else {
            Map<String, dynamic> responseData = response.data;
            var data = responseData['data']['total_likes'];
            int postIndex = postList.indexWhere((post) => post.id == postId);
            if(postIndex != -1) {
              postList[postIndex].liked = !postList[postIndex].liked;
              postList[postIndex].postLike = data;
              postList.refresh();
            }
          }
        } else {
          print(response.data['message']);
        }
      } catch (e) {
        throw Exception(e);
      }
  }

  Future<void> getDetailPost(int postId) async{
    try {
      var response = await dio.post(
        '${Api.baseUrl}/post/detail-post',
        data: {
          'id': postId
        },
        options: Options(
            headers: {
              "Authorization": "Bearer ${authController.userAuth.value!.token}"
            }
        ),
      );

      if(response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        var detail = responseData['data']['post'];
        Post postdetail = Post.fromJson(detail);
        setDetail(postdetail);
      } else {
        Get.toNamed(Routes.ERROR, arguments: {'title': 'Masuk untuk melihat semua fitur'});
        print(response.data['message']);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> getViewers(int postId) async {
    try{
      var response = await dio.post(
        '${Api.baseUrl}/post/detail-postview',
        data: {
          'post_id': postId
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
        viewerPost.value = data.map((json) => User.fromJson(json)).toList();
      } else {
        Get.toNamed(Routes.ERROR, arguments: {'title': 'Coming Soon'});
        throw Exception('error');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}