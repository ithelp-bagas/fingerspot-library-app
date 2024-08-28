import 'package:dio/dio.dart';
import 'package:fingerspot_library_app/helpers/api.dart';
import 'package:fingerspot_library_app/models/auth_model.dart';
import 'package:fingerspot_library_app/models/pwa_model.dart';
import 'package:fingerspot_library_app/routes/app_routes.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  Dio dio = Dio();
  String encoded = 'FINIn0=c2VyX2lkIjozNjQ3MywidHlwZSI6MiwiY29tcGFueV9pZCI6MTI3NzYsInBhY2thZ2VfaWQiOjYsImVtcF9pZCI6OTk3ODUsImVtcF9waW4iOiIxIiwibW9kdWxlX2lkIjozLCJpcF9hZGRyZXNzIjoiMTkyLjE2OC4xLjkxIiwicGxhdGZvcm0iOiJhbmRyb2lkIiwibGFuZ3VhZ2UiOiJpZCIsInRoZW1lIjoibGlnaHQiLCJlbWFpbCI6ImFkbWluQGZpbmdlcnNwb3QuY29teyJ1SPOT';
  var userAuth = Rxn<Auth>();
  var pwa = Rxn<Pwa>();

  void setAuth(Auth newAuth) {
    userAuth.value = newAuth;
  }

  void setPwa(Pwa newPwa){
    pwa.value = newPwa;
  }

  Future<void> login() async{
    try {
      var response = await dio.post('${Api.baseUrl}/login?data=${encoded}');

      var pwaData = response.data['pwa'];
      Pwa pwa = Pwa.fromJson(pwaData);
      setPwa(pwa);

      if(response.statusCode == 200) {
        bool success = response.data['success'];
        if(success) {
          var data = response.data['data'];
          Auth auth = Auth.fromJson(data);
          setAuth(auth);
        } else {
          Get.toNamed(Routes.ERROR, arguments: {'title': 'Masuk untuk melihat semua fitur'});
          print(response.data['message']);
        }
      } else {
        Get.toNamed(Routes.ERROR, arguments: {'title': 'Coming Soon'});
      }
    } catch(e){
      throw Exception(e);
    }
  }
}