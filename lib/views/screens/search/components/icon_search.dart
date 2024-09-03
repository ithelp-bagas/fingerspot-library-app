import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconSearch extends StatelessWidget {
  const IconSearch({super.key, required this.icon, required this.label, this.color});
  final IconData icon;
  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 5.h),
      child: Row(
        children: [
          Icon(
            icon,
            size: p3,
            color: color ?? Theme.of(context).iconTheme.color,
          ),
          SizedBox(width: 5.h,),
          Text(
            label,
            style: TextStyle(
                fontSize: p3,
                fontWeight: regular
            ),
          ),
        ],
      ),
    );
  }
}
