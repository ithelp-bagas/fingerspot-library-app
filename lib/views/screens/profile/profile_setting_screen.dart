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
        title: Text(
          'Edit Profil',
          style: TextStyle(
            fontSize: h4,
            fontWeight: heavy
          )
        ),
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
                      'assets/images/profile.jpg',
                      height: 60.h,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 10.h,),
                    Text(
                      'Edit Foto',
                      style: TextStyle(
                        fontSize: p2,
                        fontWeight: heavy,
                        color: Theme.of(context).primaryColor
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
              const TextInputFieldCustom(text: 'Nama Depan', icon: Icons.person, useRequired: true,),
              const TextInputFieldCustom(text: 'Nama Belakang', icon: Icons.person, useRequired: true,),
              const TextInputFieldCustom(text: 'Email', icon: Icons.mail, useRequired: true,),
              const TextInputFieldCustom(text: 'No Ponsel', icon: Icons.person, useRequired: true,),
              const TextInputFieldCustom(text: 'Negara', icon: Icons.location_on, useRequired: true,),
              const TextInputFieldCustom(text: 'Provinsi', icon: Icons.person, useRequired: true,),
              const TextInputFieldCustom(text: 'Kabupaten / Kota', icon: Icons.person, useRequired: true,),
              const TextInputFieldCustom(text: 'Kode Pos', icon: Icons.maps_home_work_outlined, useRequired: true,),
              const TextInputFieldCustom(text: 'Alamat', icon: Icons.map_outlined, useRequired: true,),
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
              const TextInputFieldCustom(text: 'Keahlian', icon: Icons.manage_accounts, useRequired: true,),
              ElevatedButton(
                onPressed: (){},
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50.h),
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: kLight,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.h)
                    )
                ),
                child: const Text('Simpan'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
