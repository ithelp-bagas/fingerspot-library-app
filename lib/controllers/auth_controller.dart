import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fingerspot_library_app/helpers/api.dart';
import 'package:fingerspot_library_app/helpers/shared_pref.dart';
import 'package:fingerspot_library_app/models/auth_model.dart';
import 'package:fingerspot_library_app/models/pwa_model.dart';
import 'package:fingerspot_library_app/routes/app_routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/main.dart';


class AuthController extends GetxController {
  Dio dio = Dio();
  var userAuth = Rxn<Auth>();
  var pwa = Rxn<Pwa>();
  RxBool isSuccess = false.obs;
  RxString responsed = ''.obs;
  RxString tokenSavedAuth = ''.obs;

  void setAuth(Auth newAuth) {
    userAuth.value = newAuth;
  }

  void setPwa(Pwa newPwa){
    pwa.value = newPwa;
  }

  Future<void> login() async{
    try {
      String? encodedData = await SharedPref().getEncoded();
      print(encodedData);
      var response = await dio.post(
          '${Api.baseUrl}/login?data=$encodedData'
      );

      var pwaData = response.data['pwa'];
      Pwa pwaConfig = Pwa.fromJson(pwaData);
      setPwa(pwaConfig);
      await SharedPref().storePwa(json.encode(pwaData['theme']));

      if (pwaConfig.theme == 'light') {
        Get.changeThemeMode(ThemeMode.light);
      } else if (pwaConfig.theme == 'dark') {
        Get.changeThemeMode(ThemeMode.dark);
      }

      if(response.statusCode == 200) {
        bool success = response.data['success'];
        if(success) {
          var data = response.data['data'];
          Auth auth = Auth.fromJson(data);
          setAuth(auth);
          await SharedPref().storeToken(auth.token);
          String? token = await SharedPref().getToken();
          if (token != null) {
            tokenSavedAuth.value = token;
            isSuccess.value = true;
          } else {
            isSuccess.value = false;
          }

          isSuccess.value = true;
          responsed.value = response.data['data'].toString();
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Get.toNamed(Routes.ERROR, arguments: {'title': 'Masuk untuk melihat semua fitur'});
          });
            print(response.data['message']);
        }
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.toNamed(Routes.ERROR, arguments: {'title': 'Masuk untuk melihat semua fitur'});
        });
        isSuccess.value = false;
      }
    } catch(e){
        Get.toNamed(Routes.ERROR, arguments: {'title': 'Masuk untuk melihat semua fitur'});

      // WidgetsBinding.instance.addPostFrameCallback((_) {
      // });
      isSuccess.value = false;
      throw Exception(e);
    }
  }
}