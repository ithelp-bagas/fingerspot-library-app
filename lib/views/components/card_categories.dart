import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardCategories extends StatelessWidget {
  const CardCategories({super.key, required this.categoriesName, required this.isSelected});
  final String categoriesName;
  final bool isSelected;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.h),
      child: Text(
        categoriesName,
        style: TextStyle(
          // color: isSelected ? kPrimary : kBlack,
          color: Colors.transparent,
          fontWeight: isSelected ? heavy : regular,
          fontSize: smLabel,
          shadows: [
            Shadow(
                color: isSelected ? kPrimary : kBlack,
                offset: const Offset(0, -8))
          ],
          decoration: isSelected ? TextDecoration.underline : TextDecoration.none,
          decorationColor: kPrimary,
          decorationThickness: 3.h,
        ),
      ),
    );
  }
}
