import 'package:fingerspot_library_app/controllers/auth_controller.dart';
import 'package:fingerspot_library_app/helpers/shared_pref.dart';
import 'package:fingerspot_library_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final SplashScreenController splashScreenController = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class SplashScreenController extends GetxController {
  @override
  void onReady() async{
    // TODO: implement onReady
    // Extract the 'data' parameter from the URL before the app runs
    super.onReady();

    Uri currentUri = Uri.base;
    String? data = currentUri.queryParameters['data'];

    if (data != null) {
      await SharedPref().storeEncodedData(data);
      AuthController authController = Get.find<AuthController>();

      bool successLogin = await authController.login(); // Assuming login fetches and stores the token
      if(successLogin) {
        Get.offAllNamed(Routes.HOME);
        return;
      }
    } else {
      print('No data parameter found in URL');
    }

    Get.offAllNamed(Routes.ERROR, arguments: {'title' : 'Silahkan masuk untuk melihat semua fitur'});

  }
}
