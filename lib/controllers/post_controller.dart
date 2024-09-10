

import 'package:dio/dio.dart';
import 'package:fingerspot_library_app/helpers/api.dart';
import 'package:fingerspot_library_app/helpers/shared_pref.dart';
import 'package:fingerspot_library_app/models/category_model.dart';
import 'package:fingerspot_library_app/models/post_model.dart';
import 'package:fingerspot_library_app/models/tag_model.dart';
import 'package:fingerspot_library_app/models/user_model.dart';
import 'package:fingerspot_library_app/models/votes_model.dart';
import 'package:fingerspot_library_app/routes/app_routes.dart';
import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:fingerspot_library_app/views/screens/profile/profile_visit_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PostController extends GetxController{
  Dio dio = Dio();

  RxList<Post> postList = RxList<Post>([]);
  RxList<Post> searchPostList = RxList<Post>([]);
  RxList<Post> recommendedList = RxList<Post>([]);
  RxList<Post> bookmarkPostList = RxList<Post>([]);
  RxList<Post> profilePostList = RxList<Post>([]);
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
  final searchController = TextEditingController();
  var charCount = 0.obs;
  String? tokenVariable = '';
  RxBool isSearchResultAvailable = true.obs;
  RxList<Post> searchPost = RxList<Post>([]);
  RxList<Tag> allTags = RxList<Tag>([]);
  RxList<Tag> searchTag = RxList<Tag>([]);
  RxString searchText = ''.obs;

  @override
  void onClose() {
    komentarController.dispose();
    reasonController.dispose();
    super.onClose();
  }

  @override
  void onInit() async{
    super.onInit();
    reasonController.addListener(_updateCharCount);
  }

  void searchingPost(String query) {
    searchPost.clear();
    searchTag.clear();

    if (query.isEmpty) {
      // When the query is empty, show all posts and tags
      searchPost.addAll(searchPostList);
      searchTag.addAll(allTags);
      isSearchResultAvailable.value = true;
    } else {
      searchText.value = query;

      // Search tags
      var resultTag = allTags.where((tag) {
        bool nameMatch = tag.name.toLowerCase().contains(query.toLowerCase());
        return nameMatch;
      }).toList();

      // Search posts
      var resultPost = searchPostList.where((post) {
        bool titleMatch = post.title.toLowerCase().contains(query.toLowerCase());
        bool userFirstNameMatch = post.user.firstname.toLowerCase().contains(query.toLowerCase());
        bool userLastNameMatch = post.user.lastname.toLowerCase().contains(query.toLowerCase());
        bool categoryNameMatch = post.categoryName.toLowerCase().contains(query.toLowerCase());

        return titleMatch || userFirstNameMatch || userLastNameMatch || categoryNameMatch;
      }).toList();

      // Add the filtered tags and posts
      searchTag.addAll(resultTag);
      searchPost.addAll(resultPost);

      // Check if there are any search results
      isSearchResultAvailable.value = resultPost.isNotEmpty || resultTag.isNotEmpty;
    }
  }

  void searchByTags(List<String> tags) {
    searchPost.clear();

    if (tags.isEmpty) {
      searchPost.addAll(searchPostList);
      isSearchResultAvailable.value = true;
    } else {
      final filteredPosts = searchPostList.where((post) {
        // Check if any tag in the post's tags list matches any of the tags in the filter list
        return tags.any((tag) => post.tags.any((postTag) => postTag.name == tag));
      }).toList();

      searchPost.addAll(filteredPosts);
      isSearchResultAvailable.value = filteredPosts.isNotEmpty;
    }
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
    String? token = await SharedPref().getToken();

    // String? token = await SharedPref().getToken();
    // String token = authController.tokenSavedAuth.value;
    // print('token from auth category : ($token)');
    // await Future.delayed(Duration(seconds: 1));

    try {
      var response = await dio.get(
        '${Api.baseUrl}/post/list-category',
        options: Options(
            headers: {
              "Authorization": "Bearer $token",
            }
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        List<dynamic> data = responseData['data'];
        categoryList.value = data.map((json) => Category.fromJson(json)).toList();
      } else {
        Get.toNamed(Routes.ERROR, arguments: {'title': 'Masuk untuk melihat semua fitur'});
        throw Exception('error');
      }
    } catch (e) {
      if (e is DioError) {
        final statusCode = e.response?.statusCode;
        if (statusCode == 401) {
          Get.toNamed(Routes.ERROR, arguments: {'title': 'Masuk untuk melihat semua fitur'});
        } else {
          Get.toNamed(Routes.ERROR, arguments: {'title': 'Masuk untuk melihat semua fitur'});
        }
      } else {
        // Handle any other errors
        print(e);
      }
      throw Exception(e);
    }
  }


  Future<void> getPost(int categoryId) async {
    String? token = await SharedPref().getToken();
    // String token = authController.tokenSavedAuth.value;
    // print('token from auth category : ($token)');g
    // await Future.delayed(Duration(seconds: 1));
    try{
      isLoading.value = true;

      var response = await dio.post(
        '${Api.baseUrl}/post/list-post',
        data: {
          'category_id': categoryId
        },
        options: Options(
            headers: {
              "Authorization": "Bearer $token",
            }
        ),
      );

      if(response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        List<dynamic> data = responseData['data'];
        postList.value = data.map((json) => Post.fromJson(json)).toList();
      } else {
        Get.toNamed(Routes.ERROR, arguments: {'title': 'Belum ada data post'});
        throw Exception('error');
      }
    } catch(e) {
      if (e is DioError) {
        print('DioError: ${e.message}');
        print('Response: ${e.response}');
      }
      throw Exception(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> likePost(int postId, bool vote, bool isDetail) async{
    String? token = await SharedPref().getToken();

      try {
        var response = await dio.post(
          '${Api.baseUrl}/post/like',
          data: {
            'post_id': postId,
            'vote': vote ? "1" : "0"
          },
          options: Options(
              headers: {
                "Authorization": "Bearer $token"
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
            int profilePostIndex = profilePostList.indexWhere((post) => post.id == postId);
            if(profilePostIndex != -1) {
              profilePostList[profilePostIndex].liked = !profilePostList[profilePostIndex].liked;
              profilePostList[profilePostIndex].postLike = data;
              profilePostList.refresh();
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

  Future<void> getDetailPost(int postId) async {
    String? token = await SharedPref().getToken();
    try {
      var response = await dio.post(
        '${Api.baseUrl}/post/detail-post',
        data: {
          'id': postId
        },
        options: Options(
            headers: {
              "Authorization": "Bearer $token"
            }
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        var detail = responseData['data']['post'];
        Post postDetail = Post.fromJson(detail);
        setDetail(postDetail);
      } else if (response.statusCode == 403) {
        // Handle 403 Forbidden error
        Get.toNamed(Routes.ERROR, arguments: {'title': 'You need to log in to view this post'});
      } else {
        Get.toNamed(Routes.ERROR, arguments: {'title': 'Masuk untuk melihat semua fitur'});
      }
    } catch (e) {
      // Optionally handle Dio exceptions (network, timeout, etc.)
      if (e is DioError && e.response?.statusCode == 403) {
        // Handle Dio error specifically for 403
        Get.toNamed(Routes.ERROR, arguments: {'title': 'Masuk untuk melihat semua fitur'});
      } else {
        // Handle general errors
        throw Exception(e);
      }
    }
  }

  Future<void> getViewers(int postId) async {
    String? token = await SharedPref().getToken();

    try{
      var response = await dio.post(
        '${Api.baseUrl}/post/detail-postview',
        data: {
          'post_id': postId
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
    String? token = await SharedPref().getToken();

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
              "Authorization": "Bearer $token"
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

  Future<void> addBookmark(int postId, String screen) async{
    String? token = await SharedPref().getToken();

    try{
      var response = await dio.post(
        '${Api.baseUrl}/post/add-bookmark',
        data: {
          'post_id': postId
        },
        options: Options(
            headers: {
              "Authorization": "Bearer $token"
            }
        ),
      );

      if(response.statusCode == 200) {


        detailPost.value?.saved = !detailPost.value!.saved;
        detailPost.refresh();


        int postIndex = postList.indexWhere((post) => post.id == postId);
        int bookmarkIndex = bookmarkPostList.indexWhere((bookmark) => bookmark.id == postId);
        int profilePostIndex = profilePostList.indexWhere((post) => post.id == postId);

        if(screen == 'home') {
          if(postIndex != -1) {
            postList[postIndex].saved = !postList[postIndex].saved;
            postList.refresh();
          }
        }

        if(screen == 'bookmark') {
          if(bookmarkIndex != -1) {
            bookmarkPostList[bookmarkIndex].saved = !bookmarkPostList[bookmarkIndex].saved;
            bookmarkPostList.refresh();
            await getBookmarkPost();
            Get.back();
          }
        }

        if(screen == 'profile') {
          if(profilePostIndex != -1) {
            profilePostList[profilePostIndex].saved = !profilePostList[profilePostIndex].saved;
            profilePostList.refresh();
          }
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
    String? token = await SharedPref().getToken();

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
              "Authorization": "Bearer $token"
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
    String? token = await SharedPref().getToken();

    try {
      var response = await dio.post(
        '${Api.baseUrl}/post/search-post',
        data: {
          'search_id': searchId
        },
        options: Options(
            headers: {
              "Authorization": "Bearer $token"
            }
        ),
      );

      if(response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        List<dynamic> data = responseData['data']['posts'];
        List<dynamic> recommended = responseData['data']['recommended'];
        searchPostList.value = data.map((json) => Post.fromJson(json)).toList();
        searchPost.value = data.map((e) => Post.fromJson(e)).toList();
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
    String? token = await SharedPref().getToken();

    try {
      var response = await dio.get(
        '${Api.baseUrl}/post/saved-post',
        options: Options(
            headers: {
              "Authorization": "Bearer $token"
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
  
  Future<void> getAllTags() async{
    String? token = await SharedPref().getToken();
    
    try {
      var response = await dio.get(
        '${Api.baseUrl}/post/getAllTags',
        options: Options(
            headers: {
              "Authorization": "Bearer $token",
            }
        ),
      );

      if(response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        List<dynamic> data = responseData['data'];
        allTags.value = data.map((json) => Tag.fromJson(json)).toList();
        searchTag.value = data.map((json) => Tag.fromJson(json)).toList();
      } else {
        Get.toNamed(Routes.ERROR, arguments: {'title': 'Masuk untuk melihat semua fitur'});
        throw Exception('error');
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }


  void copyLink(String link) {
    Clipboard.setData(ClipboardData(text: link));
    Get.snackbar('Success', 'Tautan berhasil disalin!', backgroundColor: kSuccess, colorText: kLight);
  }
}