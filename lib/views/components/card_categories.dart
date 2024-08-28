import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardCategories extends StatelessWidget {
  const CardCategories({super.key, required this.categoriesName, required this.color});
  final String categoriesName;
  final Color color;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.h),
      child: Text(
        categoriesName,
        style: TextStyle(
            color: color,
            fontWeight: heavy,
            fontSize: smLabel
        ),
      ),
    );
  }
}
