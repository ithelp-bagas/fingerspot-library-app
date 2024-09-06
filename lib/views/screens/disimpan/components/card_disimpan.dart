import 'package:cached_network_image/cached_network_image.dart';
import 'package:fingerspot_library_app/controllers/post_controller.dart';
import 'package:fingerspot_library_app/helpers/api.dart';
import 'package:fingerspot_library_app/helpers/helpers.dart';
import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CardDisimpan extends StatelessWidget {
  CardDisimpan({super.key, required this.postId, required this.nameUser, required this.imgPath, required this.date, required this.categoryName, required this.title, required this.index});
  final int postId;
  final String nameUser;
  final String imgPath;
  final String date;
  final String categoryName;
  final String title;
  final int index;

  final PostController postController = Get.put(PostController());

  Helper helper = Helper();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: imgPath.isNotEmpty
                    ? CachedNetworkImage(
                  imageUrl: Api.imgurl + imgPath,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 28.h,
                    height: 28.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.h),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: 28.h,
                    height: 28.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.h),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/profile_large.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
                    : Container(
                  width: 28.h,
                  height: 28.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.h),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/profile_large.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.h,),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nameUser,
                      style: TextStyle(
                          fontSize: p2,
                          fontWeight: heavy
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Dibuat ${helper.dayDiff(date)}',
                      style: TextStyle(
                          fontSize: p2,
                          fontWeight: regular
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.chat, size: p2, color: kPrimary,),
                    SizedBox(width: 5.w,),
                    Text(
                      "Topik $categoryName",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: kPrimary,
                          fontSize: p3,
                          fontWeight: heavy
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: PopupMenuButton(
                  itemBuilder:  (context) => [
                    PopupMenuItem(
                      onTap: () async{
                        Get.dialog(
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 40),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).canvasColor,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Material(
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 10),
                                          const Text(
                                            "Apakah anda akan menghapus postingan ini dari daftar “Disimpan” ",
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(height: 20),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    foregroundColor: Theme.of(context).primaryColorLight,
                                                    backgroundColor: Theme.of(context).primaryColorDark,
                                                    minimumSize: const Size(0, 45),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  child: const Text(
                                                    'Kembali',
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    foregroundColor: const Color(0xFFFFFFFF),
                                                    backgroundColor: kPrimary,
                                                    minimumSize: const Size(0, 45),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                  ),
                                                  onPressed: () async {
                                                    await postController.addBookmark(postId);
                                                  },
                                                  child: const Text(
                                                    'Ya, Hapus',
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.delete_outline,
                          ),
                          SizedBox(width: 5.w,),
                          Text(
                            'Hapus',
                            style: TextStyle(
                                fontSize: smLabel,
                                fontWeight: regular
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        Get.dialog(
                          Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Material(
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
                                      controller: postController.reasonController,
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
                                              '${postController.charCount.value}/300',
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
                                                backgroundColor: postController.charCount.value < 1 ? kGrey : kPrimary,
                                                minimumSize: const Size(0, 45),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                              ),
                                              onPressed: postController.charCount.value < 1
                                                  ? () {}
                                                  : () async {
                                                if (!postController.isLoading.value) {
                                                  postController.isLoading.value = true;

                                                  // Execute the report function
                                                  await postController.reportPost(postId, postController.reasonController.text);

                                                  // Reset loading state
                                                  postController.isLoading.value = false;

                                                  // Clear the controller and reset the count
                                                  postController.reasonController.clear();
                                                  postController.charCount.value = 0;
                                                }
                                              },
                                              child: postController.isLoading.value
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
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.report_outlined),
                          SizedBox(width: 5.w,),
                          Text(
                            'Laporkan',
                            style: TextStyle(
                                fontSize: smLabel,
                                fontWeight: regular
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      onTap: (){
                        postController.copyLink(Api.defaultUrl + postController.postList[index].link);
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.link_rounded),
                          SizedBox(width: 5.w,),
                          Text(
                            'Salin Tautan',
                            style: TextStyle(
                                fontSize: smLabel,
                                fontWeight: regular
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h,),
          Text(
            title,
            style: TextStyle(
                fontSize: p2,
                fontWeight: heavy
            ),
          ),
          SizedBox(height: 10.h,),
          const Divider(
            color: kGrey,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
