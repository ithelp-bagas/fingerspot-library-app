import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchTags extends StatelessWidget {
  const SearchTags({super.key, required this.tagsName, required this.onTap});
  final String tagsName;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal:10.h, vertical: 5.h),
      decoration: BoxDecoration(
          color: kThird,
          borderRadius: BorderRadius.circular(50.h)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            tagsName,
            style: TextStyle(
                color: Theme.of(context).textTheme.labelMedium?.color,
                fontSize: xsLabel,
                fontWeight: regular
            ),
          ),
          SizedBox(width: 5.h,),
          GestureDetector(
            onTap: onTap,
            child: Icon(Icons.clear, size: xsLabel,),
          )
        ],
      ),
    );
  }
}
