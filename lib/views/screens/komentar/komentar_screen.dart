import 'package:cached_network_image/cached_network_image.dart';
import 'package:fingerspot_library_app/controllers/post_controller.dart';
import 'package:fingerspot_library_app/helpers/api.dart';
import 'package:fingerspot_library_app/helpers/helpers.dart';
import 'package:fingerspot_library_app/models/post_model.dart';
import 'package:fingerspot_library_app/views/components/expandable_text.dart';
import 'package:fingerspot_library_app/views/components/text_input_field.dart';
import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:fingerspot_library_app/views/screens/home/components/icon_home.dart';
import 'package:fingerspot_library_app/views/screens/komentar/card_single_comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class KomentarScreen extends StatelessWidget {
  KomentarScreen({super.key});
  final PostController postController = Get.put(PostController());
  Helper helper = Helper();

  Future<void> _loadData(int postId) async{
    await postController.getDetailPost(postId);
  }

  @override
  Widget build(BuildContext context) {
    var args = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Komentar (${args['komentar']})"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _loadData(args['postId']),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);
          } else if(snapshot.hasError) {
            return Center(child: Text('error'),);
          } else {
            var post = postController.detailPost.value;
            if(post!.comments.isEmpty) {
              return RefreshIndicator(
                onRefresh: () async {
                  await postController.getDetailPost(post.id);
                },
                child: SizedBox(
                    height: MediaQuery.of(context).size.height * .7,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/no_data.png', width: 100.h,),
                          Text(
                            'Belum ada data',
                            style: TextStyle(
                                fontSize: defLabel,
                                fontWeight: heavy
                            ),
                          )
                        ],
                      ),
                    )),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: post.comments.length,
                      itemBuilder: (context, index) {
                        final comment = post.comments[index];
                        return CardSingleComment(
                          imgPath: comment.user.image,
                          name: '${comment.user.firstname} ${comment.user.lastname}',
                          date: comment.createdAt,
                          komentar: comment.comment,
                          like: 1, // Example data; adjust as needed
                          balasan: 3, // Example data; adjust as needed
                        );
                      },
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * .06,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0), // Optional: add border radius for better styling
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Add a comment...', // Optional: placeholder text
                              contentPadding: EdgeInsets.symmetric(horizontal: 8.0), // Add padding inside the TextFormField
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0), // Add padding around the icon
                          child: IconButton(
                            onPressed: (){},
                            icon: const Icon(Icons.send, color: kPrimary,),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      )
    );
  }
}
