import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardUploadGambar extends StatelessWidget {
  const CardUploadGambar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gambar',
          style: TextStyle(
              fontSize: h4,
              fontWeight: heavy
          ),
        ),
        Text(
          'Ekstensi File yang Diizinkan: .jpg, .jpeg, .png (maks: 2MB)',
          style: TextStyle(
              fontSize: p2,
              fontWeight: regular,
              color: Theme.of(context).hintColor
          ),
        ),
        SizedBox(height: 5.h,),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(5.h),
          decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Theme.of(context).hintColor, width: 1.h),
                left: BorderSide(color: Theme.of(context).hintColor, width: 1.h),
                bottom: BorderSide(color: Theme.of(context).hintColor, width: 1.h),
                right: BorderSide(color: Theme.of(context).hintColor, width: 1.h),
              ),
              borderRadius: BorderRadius.circular(5.h)
          ),
          child: Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).canvasColor,
                    side: BorderSide(
                        color: Theme.of(context).primaryColor
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.h)
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 2.h)
                ),
                onPressed: (){},
                child: Text(
                  'Pilih Gambar',
                  style: TextStyle(
                      fontSize: xsLabel,
                      fontWeight: regular
                  ),
                ),
              ),
              SizedBox(width: 5.h,),
              Expanded(
                child: Text(
                  'Tidak ada yang dipilih',
                  style: TextStyle(
                      fontSize: p2,
                      fontWeight: regular,
                      color: Theme.of(context).disabledColor
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class CardUploadFile extends StatelessWidget {
  const CardUploadFile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Lampiran',
          style: TextStyle(
              fontSize: h4,
              fontWeight: heavy
          ),
        ),
        Text(
          'Ekstensi File yang Diizinkan: .pdf, .doc/docx, .xls/xlsx, .txt (max: 5MB)',
          style: TextStyle(
              fontSize: p2,
              fontWeight: regular,
              color: Theme.of(context).hintColor
          ),
        ),
        SizedBox(height: 5.h,),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(5.h),
          decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Theme.of(context).hintColor, width: 1.h),
                left: BorderSide(color: Theme.of(context).hintColor, width: 1.h),
                bottom: BorderSide(color: Theme.of(context).hintColor, width: 1.h),
                right: BorderSide(color: Theme.of(context).hintColor, width: 1.h),
              ),
              borderRadius: BorderRadius.circular(5.h)
          ),
          child: Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).canvasColor,
                    side: BorderSide(
                        color: Theme.of(context).primaryColor
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.h)
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 2.h)
                ),
                onPressed: (){},
                child: Text(
                  'Pilih File',
                  style: TextStyle(
                      fontSize: xsLabel,
                      fontWeight: regular
                  ),
                ),
              ),
              SizedBox(width: 5.h,),
              Expanded(
                child: Text(
                  'Tidak ada yang dipilih',
                  style: TextStyle(
                      fontSize: p2,
                      fontWeight: regular,
                      color: Theme.of(context).disabledColor
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

