import 'package:dio/dio.dart';
import 'package:fingerspot_library_app/controllers/post_controller.dart';
import 'package:fingerspot_library_app/helpers/api.dart';
import 'package:fingerspot_library_app/helpers/shared_pref.dart';
import 'package:fingerspot_library_app/models/post_model.dart';
import 'package:fingerspot_library_app/models/profile_model.dart';
import 'package:fingerspot_library_app/routes/app_routes.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final Dio dio = Dio();
  var profileDetail = Rxn<Profile>();
  RxBool isLoading = false.obs;
  final PostController postController = Get.put(PostController());

  void setProfile(Profile newProfile){
    profileDetail.value = newProfile;
  }

  Future<void> getProfile(int? profileId) async {
    String? token = await SharedPref().getToken();
    try {
      var response = await dio.post(
        '${Api.baseUrl}/profile/details',
        data: {
          'profile_id': profileId
        },
        options: Options(
            headers: {
              "Authorization": "Bearer $token"
            }
        ),
      );

      if(response.statusCode == 200) {
        var data = response.data['data']['profile'];
        List<dynamic> post = response.data['data']['posts'];
        postController.postList.value = post.map((json) => Post.fromJson(json)).toList();
        Profile profile = Profile.fromJson(data);
        setProfile(profile);
      } else {
        print(response.statusCode);
        Get.offAllNamed(Routes.ERROR, arguments: {'title': 'Coming Soon'});
      }
    } catch(e) {
      print(e);
      throw Exception(e);
    }
  }
}