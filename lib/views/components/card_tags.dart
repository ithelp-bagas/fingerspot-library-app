import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardTags extends StatelessWidget {
  const CardTags({super.key, required this.tagsName});
  final String tagsName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal:10.h, vertical: 5.h),
      decoration: BoxDecoration(
          color: kThird,
          borderRadius: BorderRadius.circular(50.h)
      ),
      child: Text(
        tagsName,
        style: TextStyle(
            color: Theme.of(context).textTheme.labelMedium?.color,
            fontSize: xsLabel,
            fontWeight: regular
        ),
      ),
    );
  }
}
