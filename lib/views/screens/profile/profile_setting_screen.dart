import 'package:fingerspot_library_app/views/components/text_input_field.dart';
import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProfileSettingScreen extends StatelessWidget {
  const ProfileSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Edit Profil'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/profile_large.png',
                      height: 60.h,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 10.h,),
                    Text(
                      'Edit Foto',
                      style: TextStyle(
                        fontSize: p2,
                        fontWeight: heavy,
                        color: kPrimary
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h,),
              Text(
                'Informasi Pribadi',
                style: TextStyle(
                  fontSize: defLabel,
                  fontWeight: medium
                ),
              ),
              SizedBox(height: 10.h,),
              TextInputFieldCustom(text: 'Nama Depan', icon: Icons.person, useRequired: true,),
              TextInputFieldCustom(text: 'Nama Belakang', icon: Icons.person, useRequired: true,),
              TextInputFieldCustom(text: 'Email', icon: Icons.mail, useRequired: true,),
              TextInputFieldCustom(text: 'No Ponsel', icon: Icons.person, useRequired: true,),
              TextInputFieldCustom(text: 'Negara', icon: Icons.location_on, useRequired: true,),
              TextInputFieldCustom(text: 'Provinsi', icon: Icons.person, useRequired: true,),
              TextInputFieldCustom(text: 'Kabupaten / Kota', icon: Icons.person, useRequired: true,),
              TextInputFieldCustom(text: 'Kode Pos', icon: Icons.maps_home_work_outlined, useRequired: true,),
              TextInputFieldCustom(text: 'Alamat', icon: Icons.map_outlined, useRequired: true,),
              TextInputFieldCustom(text: 'Instagram', icon: MdiIcons.instagram, useRequired: true,),
              TextInputFieldCustom(text: 'Facebook', icon: MdiIcons.facebook, useRequired: true,),
              TextInputFieldCustom(text: 'Twitter', icon: MdiIcons.twitter, useRequired: true,),
              Text(
                'Tambahkan Keahlian',
                style: TextStyle(
                    fontSize: defLabel,
                    fontWeight: medium
                ),
              ),
              SizedBox(height: 10.h,),
              TextInputFieldCustom(text: 'Keahlian', icon: Icons.manage_accounts, useRequired: true,),
              ElevatedButton(
                onPressed: (){},
                child: Text('Simpan'),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50.h),
                    backgroundColor: kPrimary,
                    foregroundColor: kLight,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.h)
                    )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
