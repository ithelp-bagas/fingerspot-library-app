import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCard extends StatelessWidget {
  const ShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.h),
      width: MediaQuery.of(context).size.width * 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    width: 28.h,
                    height: 28.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.h),
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 10.h,),
                Expanded(
                  flex: 5,
                  child: Container(
                    height: 16.h,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 16.h,
                    color: Colors.white,
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10.h,),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.white,
            child: Container(
              height: 25.h,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10.h,),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.white,
            child: Container(
              height: 25.h,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10.h,),
          Row(
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.white,
                child: Container(
                  width: 50.h,
                  height: 14.h,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 10.h,),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.white,
                child: Container(
                  width: 50.h,
                  height: 14.h,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 10.h,),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.white,
                child: Container(
                  width: 50.h,
                  height: 14.h,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h,),
          const Divider(
            color: kGrey,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
