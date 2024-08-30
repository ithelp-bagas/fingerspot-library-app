import 'package:fingerspot_library_app/controllers/post_controller.dart';
import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:fingerspot_library_app/views/screens/viewers/components/card_viewers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ViewersScreen extends StatelessWidget {
  ViewersScreen({super.key});
  final PostController postController = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    var param = Get.arguments;
    postController.getViewers(param['postId']);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dilihat'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.h),
        child: SizedBox(
          height: double.infinity,
          child: Obx(() {
            final viewerList = postController.viewerPost;
            if(viewerList.isEmpty){
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/no_data.png', width: 200.h,),
                    Text(
                      'Belum ada data',
                      style: TextStyle(
                          fontSize: defLabel,
                          fontWeight: heavy
                      ),
                    )
                  ],
                ),
              );
            } else {
              return ListView.builder(
                itemCount: viewerList.length,
                itemBuilder: (context, index) {
                  final viewer = viewerList[index];
                  return CardViewers(
                    name: viewer.firstname + viewer.lastname,
                    username: viewer.username,
                    imgPath: viewer.image,
                  );
                },
              );
            }
          })
        ),
      ),
    );
  }
}
