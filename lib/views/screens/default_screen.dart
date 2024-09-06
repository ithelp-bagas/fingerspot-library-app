import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';


class DefaultScreen extends StatelessWidget {
  const DefaultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var param = Get.arguments ?? {'title': 'Coming soon'};

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/no_data.png', width: 100.h,),
            Text(
              param['title'],
              style: TextStyle(
                  fontSize: defLabel,
                  fontWeight: heavy
              ),
            )
          ],
        ),
      ),
    );
  }
}
