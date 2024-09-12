import 'package:fingerspot_library_app/views/components/card_upload.dart';
import 'package:fingerspot_library_app/views/components/text_input_field.dart';
import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:fingerspot_library_app/views/screens/diskusi/add_diskusi_screen.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_quill/flutter_quill.dart' as fq;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DiskusiScreen extends StatelessWidget {
  DiskusiScreen({super.key});
  // final fq.QuillController _quillController = fq.QuillController.basic();

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        AddDiskusiScreen(),
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10.h),
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CardUploadGambar(),
                  SizedBox(height: 10.h,),
                  CardUploadFile(),
                  SizedBox(height: 10.h,),
                  Text(
                    'Text',
                    style: TextStyle(
                        fontSize: h4,
                        fontWeight: heavy
                    ),
                  ),
                  Wrap(
                    children: [
                      // fq.QuillSimpleToolbar(
                      //   controller: _quillController,
                      //   configurations: const fq.QuillSimpleToolbarConfigurations(
                      //     multiRowsDisplay: false,
                      //     showBackgroundColorButton: false,
                      //     showFontSize: false,
                      //     showFontFamily: false,
                      //     showInlineCode: false,
                      //     showSubscript: false,
                      //     showSuperscript: false,
                      //     showColorButton: false,
                      //     showHeaderStyle: false,
                      //     showSearchButton: false,
                      //     showClipboardCopy: false,
                      //     showClipboardPaste: false,
                      //     showClipboardCut: false,
                      //     showUndo: false,
                      //     showRedo: false
                      //   ),
                      // )
                    ]
                  ),
                  // Container(
                  //   padding: EdgeInsets.all(10.h),
                  //   decoration: BoxDecoration(
                  //     border: Border(
                  //       top: BorderSide(color: Theme.of(context).hintColor, width: 1.h),
                  //       right: BorderSide(color: Theme.of(context).hintColor, width: 1.h),
                  //       bottom: BorderSide(color: Theme.of(context).hintColor, width: 1.h),
                  //       left: BorderSide(color: Theme.of(context).hintColor, width: 1.h),
                  //     ),
                  //     borderRadius: BorderRadius.circular(5.h)
                  //   ),
                  //   child: fq.QuillEditor.basic(
                  //     controller: _quillController,
                  //     configurations: fq.QuillEditorConfigurations(
                  //       minHeight: 50.h
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 10.h,),
                  ElevatedButton(onPressed: (){}, child: Text('data'))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
