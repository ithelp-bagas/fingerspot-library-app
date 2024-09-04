import 'dart:convert';

import 'package:dio/dio.dart';
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

  @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
    String? encodedToken = await SharedPref().getEncoded();
    login(encodedToken!);
  }

  void setAuth(Auth newAuth) {
    userAuth.value = newAuth;
  }

  void setPwa(Pwa newPwa){
    pwa.value = newPwa;
  }

  checkPwaConfig() async {
    var pwa = await SharedPref().getPwa();
  }

  Future<void> login(String encoded) async{
    try {
      var response = await dio.post('${Api.baseUrl}/login?data=$encoded');

      var pwaData = response.data['pwa'];
      Pwa pwaConfig = Pwa.fromJson(pwaData);
      setPwa(pwaConfig);
      await SharedPref().storePwa(json.encode(pwaConfig.theme));
      // await SharedPref().storePwa(json.encode(pwaConfig.toJson()));

      if(response.statusCode == 200) {
        bool success = response.data['success'];
        if(success) {
          var data = response.data['data'];
          var token = response.data['data']['token'];
          await SharedPref().storeToken(token);
          Auth auth = Auth.fromJson(data);
          setAuth(auth);
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
      Get.toNamed(Routes.ERROR, arguments: {'title': 'Masuk untuk melihat semua fitur'});
      throw Exception(e);
    }
  }
}