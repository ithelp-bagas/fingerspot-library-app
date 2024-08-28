import 'package:fingerspot_library_app/views/components/text_input_field.dart';
import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DiskusiScreen extends StatelessWidget {
  const DiskusiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.h),
      child: Container(
        height: MediaQuery.of(context).size.height * .9,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextInputFieldCustom(
                useRequired: true,
                text: 'Judul',
                icon: MdiIcons.formatTitle,
              ),
              TextInputFieldCustom(
                useRequired: true,
                text: 'Kategori',
                icon: MdiIcons.shape,
              ),
              TextInputFieldCustom(
                text: 'SubKategori',
                icon: MdiIcons.shape,
              ),
              const TextInputFieldCustom(
                useRequired: true,
                text: 'Tags',
                icon: FontAwesomeIcons.hashtag,
              ),
              Text(
                "Sesuaikan Postingan Anda",
                style: TextStyle(
                  fontSize: defLabel,
                  fontWeight: medium
                ),
              ),
              SizedBox(height: 10.h,),
              TextInputFieldCustom(
                useRequired: true,
                text: 'Tujuan Kantor',
                icon: MdiIcons.officeBuilding
              ),
              TextInputFieldCustom(
                useRequired: true,
                text: 'Departemen',
                icon: MdiIcons.homeAccount,
              ),
              const TextInputFieldCustom(
                useRequired: true,
                text: 'Posisi',
                icon: Icons.work,
              ),
              TextInputFieldCustom(
                useRequired: true,
                text: 'Pengguna',
                icon: MdiIcons.accountGroup,
              ),
              SizedBox(height: 10.h,),
              ElevatedButton(
                onPressed: (){},
                child: Text('Selanjutnya'),
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
