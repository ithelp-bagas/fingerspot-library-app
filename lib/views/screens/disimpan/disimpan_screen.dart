import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:fingerspot_library_app/views/screens/disimpan/components/card_disimpan.dart';
import 'package:fingerspot_library_app/views/screens/search/components/icon_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DisimpanScreen extends StatelessWidget {
  const DisimpanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.h),
      child: Container(
        height: MediaQuery.of(context).size.height * .9,
        child: SingleChildScrollView(
          child: Column(
            children: [
              CardDisimpan(),
              CardDisimpan(),
              CardDisimpan(),
              CardDisimpan(),
              CardDisimpan(),
              CardDisimpan(),
              CardDisimpan(),
              CardDisimpan(),
              CardDisimpan(),
              CardDisimpan(),
              CardDisimpan(),
              CardDisimpan(),
              CardDisimpan(),
              CardDisimpan(),
              CardDisimpan(),
              CardDisimpan(),
              CardDisimpan(),
              CardDisimpan(),
              CardDisimpan(),
              CardDisimpan(),
              CardDisimpan(),
              CardDisimpan(),
            ],
          ),
        ),
      ),
    );
  }
}
