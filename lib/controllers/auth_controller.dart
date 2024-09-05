import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fingerspot_library_app/controllers/post_controller.dart';
import 'package:fingerspot_library_app/helpers/api.dart';
import 'package:fingerspot_library_app/helpers/shared_pref.dart';
import 'package:fingerspot_library_app/models/auth_model.dart';
import 'package:fingerspot_library_app/models/pwa_model.dart';
import 'package:fingerspot_library_app/routes/app_routes.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';


class AuthController extends GetxController {
  Dio dio = Dio();
  var userAuth = Rxn<Auth>();
  var pwa = Rxn<Pwa>();
  RxBool isSuccess = false.obs;
  RxString responsed = ''.obs;

  void setAuth(Auth newAuth) {
    userAuth.value = newAuth;
  }

  void setPwa(Pwa newPwa){
    pwa.value = newPwa;
  }

  Future<void> login() async{
    print('masuk');
    try {
      String? encodedData = await SharedPref().getEncoded();
      print('encoded data auth: $encodedData');
      print('url: ${Api.baseUrl}/login?data=$encodedData');
      var response = await dio.post(
          '${Api.baseUrl}/login?data=$encodedData'
      );

      var pwaData = response.data['pwa'];
      print('pwaData : $pwaData');
      Pwa pwaConfig = Pwa.fromJson(pwaData);
      setPwa(pwaConfig);
      await SharedPref().storePwa(json.encode(pwaConfig.theme));
      // await SharedPref().storePwa(json.encode(pwaConfig.toJson()));

      print('response : ${response.statusCode}');

      if(response.statusCode == 200) {
        bool success = response.data['success'];
        if(success) {
          var data = response.data['data'];
          print('data: $data');
          var token = response.data['data']['token'];
          print('token json: $token');
          Auth auth = Auth.fromJson(data);
          setAuth(auth);
          await SharedPref().storeToken(token);
          isSuccess.value = true;
          String? tokenAuth = await SharedPref().getToken();
          // if(tokenAuth == null) {
          //   return;
          // }
          print('token: $tokenAuth');
          responsed.value = response.data['data'].toString();
        } else {
          Get.toNamed(Routes.ERROR, arguments: {'title': 'Masuk untuk melihat semua fitur'});
          if (kDebugMode) {
            print(response.data['message']);
          }
        }
      } else {
        Get.toNamed(Routes.ERROR, arguments: {'title': 'Coming Soon'});
        print(response.data);
      }
    } catch(e){
      print(e);
      Get.toNamed(Routes.ERROR, arguments: {'title': 'Masuk untuk melihat semua fitur'});
      throw Exception(e);
    }
  }
}