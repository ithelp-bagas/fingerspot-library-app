import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconSearch extends StatelessWidget {
  const IconSearch({super.key, required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 5.h),
      child: Row(
        children: [
          Icon(
            icon,
            size: p3,
            color: kGrey,
          ),
          SizedBox(width: 5.h,),
          Text(
            label,
            style: TextStyle(
                color: kBlack,
                fontSize: p3,
                fontWeight: regular
            ),
          ),
        ],
      ),
    );
  }
}
