import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionUserInfo extends StatelessWidget {
  const SectionUserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(5.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Image.asset(
                  'assets/images/profile_large.png',
                  height: 55.h,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                flex: 9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '4.00',
                          style: TextStyle(
                              fontSize: p1,
                              fontWeight: heavy
                          ),
                        ),
                        Text(
                          'Activity Point ',
                          style: TextStyle(
                              fontSize: p2,
                              fontWeight: regular
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '4.00',
                          style: TextStyle(
                              fontSize: p1,
                              fontWeight: heavy
                          ),
                        ),
                        Text(
                          'Activity Point ',
                          style: TextStyle(
                              fontSize: p2,
                              fontWeight: regular
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '4.00',
                          style: TextStyle(
                              fontSize: p1,
                              fontWeight: heavy
                          ),
                        ),
                        Text(
                          'Activity Point ',
                          style: TextStyle(
                              fontSize: p2,
                              fontWeight: regular
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h,),
        Text(
          'Nama',
          style: TextStyle(
              fontSize: p2,
              fontWeight: bold
          ),
        ),
        Text(
          'Email',
          style: TextStyle(
              fontSize: p2,
              fontWeight: regular
          ),
        ),
        Text(
          'Perusahaan',
          style: TextStyle(
              fontSize: p2,
              fontWeight: regular
          ),
        ),
        Text(
          'Departemen',
          style: TextStyle(
              fontSize: p2,
              fontWeight: regular
          ),
        ),
      ],
    );
  }
}
