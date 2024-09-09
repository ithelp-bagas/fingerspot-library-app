import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import 'dart:js' as js;


class ComingSoon extends StatelessWidget {
  const ComingSoon({super.key});

  @override
  Widget build(BuildContext context) {
    var param = Get.arguments ?? {'title': 'Coming soon'};
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          // js.context.callMethod('backToMainApp');
        }, icon: const Icon(Icons.arrow_back_ios_new)),
      ),
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
