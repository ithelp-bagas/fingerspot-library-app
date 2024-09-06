import 'package:fingerspot_library_app/views/screens/home/components/shimmer_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShimmerHomeScreen extends StatelessWidget {
  const ShimmerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10.h,),
          SizedBox(height: 10.h,),
          SizedBox(
            height: MediaQuery.of(context).size.height * 1,
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (builder, index) {
                  return const ShimmerCard();
                }),
          ),
        ],
      ),
    );
  }
}
