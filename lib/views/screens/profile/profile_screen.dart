import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:fingerspot_library_app/views/screens/profile/components/card_profile.dart';
import 'package:fingerspot_library_app/views/screens/profile/components/section_user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.h),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .9,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionUserInfo(),
              const Divider(),
              Center(
                child: Text(
                  'My Post',
                  style: TextStyle(
                    fontSize: smLabel,
                    fontWeight: medium
                  ),
                ),
              ),
              const Divider(),
              SizedBox(height: 10.h,),
              CardProfile(),
              CardProfile(),
              CardProfile(),
              CardProfile(),
              CardProfile(),
              CardProfile(),
              CardProfile(),
              CardProfile(),
              CardProfile(),
              CardProfile(),
            ],
          ),
        ),
      ),
    );
  }
}
