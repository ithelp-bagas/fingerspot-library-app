import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TextInputFieldCustom extends StatelessWidget {
  const TextInputFieldCustom({super.key, required this.text, required this.icon, this.keyboardText, this.useRequired = false});
  final String text;
  final IconData icon;
  final TextInputType? keyboardText;
  final bool? useRequired ;


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(
                  fontSize: xsLabel,
                  fontWeight: medium
              ),
            ),
            useRequired == true ? Icon(
              MdiIcons.asterisk,
              size: p3,
              color: kDanger,
            ) : Container(),
          ],
        ),
        SizedBox(height: 5.h,),
        TextField(
          keyboardType: keyboardText ?? TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: kPrimary,),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.h)
            ),
          ),
        ),
        SizedBox(height: 10.h,)
      ],
    );
  }
}
