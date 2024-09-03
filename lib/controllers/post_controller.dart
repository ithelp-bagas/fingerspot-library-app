
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fingerspot_library_app/controllers/auth_controller.dart';
import 'package:fingerspot_library_app/helpers/api.dart';
import 'package:fingerspot_library_app/helpers/shared_pref.dart';
import 'package:fingerspot_library_app/models/category_model.dart';
import 'package:fingerspot_library_app/models/post_model.dart';
import 'package:fingerspot_library_app/models/user_model.dart';
import 'package:fingerspot_library_app/models/votes_model.dart';
import 'package:fingerspot_library_app/routes/app_routes.dart';
import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  final AuthController authController = Get.put(AuthController());
  Dio dio = Dio();
  RxList<Post> postList = RxList<Post>([]);
  RxList<Post> searchPostList = RxList<Post>([]);
  RxList<Post> recommendedList = RxList<Post>([]);
  RxList<Post> bookmarkPostList = RxList<Post>([]);
  RxList<User> viewerPost = RxList<User>([]);
  RxList<Category> categoryList = RxList<Category>([]);
  RxList searchList = RxList([
    {
      'id' : 1,
      'name': 'Terbanyak Dilihat',
    },
    {
      'id' : 2,
      'name': 'Komentar Terbanyak',
    },
    {
      'id' : 3,
      'name': 'Paling Membantu',
    }
  ]);
  RxList<Votes> votesList = RxList<Votes>([]);
  RxInt selectedCategoryId = 1.obs;
  RxInt selectedSearchId = 1.obs;
  var detailPost = Rxn<Post>();
  RxBool isLoading = false.obs;
  final komentarController = TextEditingController();
  final reasonController = TextEditingController();
  var charCount = 0.obs;
  String? token;

  Future<void> getToken() async {
    token = await SharedPref().getToken();
  }

  @override
  void onClose() {
    komentarController.dispose();
    reasonController.dispose();
    super.onClose();
  }

  @override
  void onInit() async{
    super.onInit();
    await getToken();
    await getCategory();
    await getPost(selectedCategoryId.value);
    reasonController.addListener(_updateCharCount);
  }

  void _updateCharCount() {
    if (reasonController.text.length <= 300) {
      charCount.value = reasonController.text.length;
    } else {
      // Prevent the text from exceeding 300 characters
      reasonController.text = reasonController.text.substring(0, 300);
      reasonController.selection = TextSelection.fromPosition(
        TextPosition(offset: reasonController.text.length),
      );
    }
  }

  void setDetail(Post newdetailpost) {
    detailPost.value = newdetailpost;
  }

  Future<void> tappedCategory(int categoryId) async {
    selectedCategoryId.value = categoryId;
    await getPost(categoryId);
  }

  Future<void> tappedSearchCategory(int searchCategoryId) async{
    selectedSearchId.value = searchCategoryId;
    await getSearchPost(searchCategoryId);
  }

  Future<void> getCategory() async {
    try {
      var response = await dio.get(
        '${Api.baseUrl}/post/list-category',
        options: Options(
            headers: {
              "Authorization": "Bearer $token"
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
      var response = await dio.get(
        '${Api.baseUrl}/post/list-post',
        data: {
          'category_id': categoryId
        },
        options: Options(
            headers: {
              "Authorization": "Bearer ${token}"
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
                "Authorization": "Bearer ${token}"
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
          Get.toNamed(Routes.ERROR, arguments: {'title': 'Coming Soon'});
          throw Exception('error');
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
              "Authorization": "Bearer ${token}"
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
              "Authorization": "Bearer ${token}"
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

  Future<void> comment(int postId, String comment, int countComment) async {
    try {
      isLoading.value = true;
      var response = await dio.post(
        '${Api.baseUrl}/comment/comment',
        data: {
          'post_id': postId,
          'comment': comment
        },
        options: Options(
            headers: {
              "Authorization": "Bearer ${token}"
            }
        ),
      );

      if(response.statusCode == 200) {
        await getDetailPost(postId);
        detailPost.refresh();
        Get.offNamed(Routes.KOMENTAR, arguments: {'komentar': countComment, 'postId': postId});
        komentarController.clear();
      } else {
        Get.toNamed(Routes.ERROR, arguments: {'title': 'Coming Soon'});
        throw Exception('Error');
      }
    } catch (e) {
      throw Exception(e);
    } finally {
      FocusScope.of(Get.context!).unfocus();
      isLoading.value = false;
    }
  }

  Future<void> addBookmark(int postId) async{
    try{
      var response = await dio.post(
        '${Api.baseUrl}/post/add-bookmark',
        data: {
          'post_id': postId
        },
        options: Options(
            headers: {
              "Authorization": "Bearer ${token}"
            }
        ),
      );

      if(response.statusCode == 200) {


        detailPost.value?.saved = !detailPost.value!.saved;
        detailPost.refresh();


        int postIndex = postList.indexWhere((post) => post.id == postId);
        int bookmarkIndex = bookmarkPostList.indexWhere((bookmark) => bookmark.id == postId);

        if(postIndex != -1) {
          postList[postIndex].saved = !postList[postIndex].saved;
          postList.refresh();
        }

        if(bookmarkIndex != -1) {
          bookmarkPostList[bookmarkIndex].saved = !bookmarkPostList[bookmarkIndex].saved;
          bookmarkPostList.refresh();
          await getBookmarkPost();
          Get.back();
        }

        Get.snackbar('Success', 'Berhasil ${postList[postIndex].saved ? 'menambahkan' : 'menghapus' } postingan ${postList[postIndex].saved ? 'ke' : 'dari' } daftar bookmark', backgroundColor: kPrimary, colorText: kLight, snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.toNamed(Routes.ERROR, arguments: {'title': 'Coming Soon'});
        throw Exception('error');
      }
    }catch(e) {
      throw Exception(e);
    }
  }

  Future<void> reportPost(int postId, String reason) async{
    try {
      isLoading.value = true;
      var response = await dio.post(
        '${Api.baseUrl}/post/report-post',
        data: {
          'post_id': postId,
          'reason': reason
        },
        options: Options(
            headers: {
              "Authorization": "Bearer ${token}"
            }
        ),
      );

      if(response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        var isSuccess = responseData['success'];
        if(isSuccess){
          Get.back();
          Get.snackbar('Success', 'Postingan berhasil dilaporkan!', backgroundColor: kSuccess, colorText: kLight);
        } else {
          Get.snackbar('Failed', 'Anda telah melaporkan postingan ini sebelumnya!', backgroundColor: kDanger, colorText: kLight);
        }
      } else {
        Get.toNamed(Routes.ERROR, arguments: {'title': 'Coming Soon'});
        throw Exception('error');
      }
    } catch (e) {
      throw Exception(e);
    } finally{
      isLoading.value = false;
    }
  }

  Future<void> getSearchPost(int searchId) async {
    try {
      var response = await dio.post(
        '${Api.baseUrl}/post/search-post',
        data: {
          'search_id': searchId
        },
        options: Options(
            headers: {
              "Authorization": "Bearer ${token}"
            }
        ),
      );

      if(response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        List<dynamic> data = responseData['data']['posts'];
        List<dynamic> recommended = responseData['data']['recommended'];
        searchPostList.value = data.map((json) => Post.fromJson(json)).toList();
        recommendedList.value = recommended.map((json) => Post.fromJson(json)).toList();
      } else {
        Get.toNamed(Routes.ERROR, arguments: {'title': 'Coming Soon'});
        throw Exception('error');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> getBookmarkPost() async {
    try {
      var response = await dio.get(
        '${Api.baseUrl}/post/saved-post',
        options: Options(
            headers: {
              "Authorization": "Bearer ${token}"
            }
        ),
      );

      if(response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        List<dynamic> data = responseData['data'];
        bookmarkPostList.value = data.map((json) => Post.fromJson(json)).toList();
      } else {
        Get.toNamed(Routes.ERROR, arguments: {'title': 'Coming Soon'});
        throw Exception('error');
      }
    } catch (e) {
      throw Exception(e);
    }
  }


  void copyLink(String link) {
    Clipboard.setData(ClipboardData(text: link));
    Get.snackbar('Success', 'Tautan berhasil disalin!', backgroundColor: kSuccess, colorText: kLight);
  }
}