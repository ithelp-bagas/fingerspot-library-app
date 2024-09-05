import 'package:fingerspot_library_app/controllers/auth_controller.dart';
import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:fingerspot_library_app/views/screens/home/components/shimmer_card.dart';
import 'package:fingerspot_library_app/views/screens/home/components/shimmer_home_screen.dart';
import 'package:fingerspot_library_app/views/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class Wrapper extends StatefulWidget {
  Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  final AuthController authController = Get.put(AuthController());

  Future<void> auth() async {
    await authController.login();
  }


  @override
  void initState() {
    super.initState();
    auth();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) => OrientationBuilder(
            builder: (context, Orientation orientation) {
                return MyHomePage();
              if(authController.isSuccess.value) {
              } else {
                return const ShimmerHomeScreen();
              }
            }
        )
    );
  }
}
