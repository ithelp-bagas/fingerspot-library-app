import 'package:fingerspot_library_app/views/screens/disimpan/components/card_disimpan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DisimpanScreen extends StatelessWidget {
  const DisimpanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.h),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .9,
        child: const SingleChildScrollView(
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
