import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoDataScreen extends StatelessWidget {
  const NoDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/no_data.png', width: 100.h,),
          Text(
            'Tidak ada data',
            style: TextStyle(
                fontSize: defLabel,
                fontWeight: heavy
            ),
          )
        ],
      ),
    );
  }
}
