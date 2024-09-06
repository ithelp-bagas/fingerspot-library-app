import 'package:dio/dio.dart';
import 'package:fingerspot_library_app/controllers/auth_controller.dart';
import 'package:fingerspot_library_app/helpers/api.dart';
import 'package:fingerspot_library_app/helpers/shared_pref.dart';
import 'package:fingerspot_library_app/models/category_model.dart';
import 'package:fingerspot_library_app/routes/app_routes.dart';
import 'package:get/get.dart';

class TestController extends GetxController {
  final AuthController authController = Get.put(AuthController());
  final Dio dio = Dio();
  RxList<Category> categoryList = RxList<Category>([]);


  Future<void> getCategory() async {
    // String? token = await SharedPref().getToken();

    String? token = await SharedPref().getToken();
    // String token = authController.tokenSavedAuth.value;
    print('token from auth category : ($token)');
    await Future.delayed(Duration(seconds: 1));

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
        Get.toNamed(Routes.ERROR, arguments: {'title': 'Coming Soon 1'});
        throw Exception('error');
      }
    } catch (e) {
      if (e is DioError) {
        final statusCode = e.response?.statusCode;
        print("status code + $statusCode" );
        if (statusCode == 401) {
          Get.toNamed(Routes.ERROR, arguments: {'title': 'Coming Soon 2'});
        } else {
          Get.toNamed(Routes.ERROR, arguments: {'title': 'Coming Soon 3'});
        }
      } else {
        // Handle any other errors
        print(e);
      }
      throw Exception(e);
    }
  }
}