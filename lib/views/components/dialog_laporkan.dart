import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DialogLaporkan extends StatelessWidget {
  DialogLaporkan({super.key, required this.textController, required this.charCount, required this.onPress, required this.isLoading});
  final TextEditingController textController;
  final RxInt charCount;
  final void Function() onPress;
  final RxBool isLoading;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      surfaceTintColor: Theme.of(context).cardColor,
      backgroundColor: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Material(
          color: Theme.of(context).cardColor,
          child: Column(
            mainAxisSize: MainAxisSize.min, // This makes the dialog take only as much space as needed
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Center(
                child: Text(
                  "Laporkan",
                  style: TextStyle(
                    fontSize: p1,
                    fontWeight: heavy,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "Alasan : ",
                style: TextStyle(
                  fontSize: p2,
                  fontWeight: regular,
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 10.h),
              TextFormField(
                controller: textController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.h),
                  ),
                ),
                minLines: 3,
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
              const SizedBox(height: 20),
              //Buttons
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                        () => Expanded(
                      child: Text(
                        '$charCount/300',
                        style: TextStyle(
                          fontSize: p3,
                          fontWeight: regular,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Obx(
                          () => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: kLight,
                          backgroundColor: charCount < 1 ? kGrey : Theme.of(context).primaryColor,
                          minimumSize: const Size(0, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: charCount < 1
                            ? () {}
                            : onPress,
                        child: isLoading.value
                            ? const CircularProgressIndicator()
                            : const Text('KIRIM'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
