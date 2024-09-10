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
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.only(top: 8.h),
          child: Container(
            padding: EdgeInsets.only(bottom: 2.h),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: isSelected ? Theme.of(context).primaryColor : Colors.transparent, width: 1.5.w)
              )
            ),
            child: Text(
              categoriesName,
              style: TextStyle(
                color: isSelected ? Theme.of(context).primaryColor : (Theme.of(context).textTheme.labelSmall?.color ?? kBlack),
                // color: Colors.transparent,
                fontWeight: isSelected ? heavy : regular,
                fontSize: smLabel,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
