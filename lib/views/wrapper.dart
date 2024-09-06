import 'package:fingerspot_library_app/controllers/auth_controller.dart';
import 'package:fingerspot_library_app/views/screens/home/components/shimmer_home_screen.dart';
import 'package:fingerspot_library_app/views/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    return LayoutBuilder(
        builder: (context, constraints) => OrientationBuilder(
            builder: (context, Orientation orientation) {
              return MyHomePage();
            }
        )
    );
  }
}
