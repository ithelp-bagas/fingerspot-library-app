import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconHome extends StatelessWidget {
  const IconHome({super.key, required this.icon, required this.label, this.color = kGrey});
  final IconData icon;
  final String label;
  final Color color;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10.h),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: p1,
          ),
          SizedBox(width: 5.h,),
          Text(
            label,
            style: TextStyle(
                color: kBlack,
                fontSize: p2,
                fontWeight: regular
            ),
          ),
        ],
      ),
    );
  }
}