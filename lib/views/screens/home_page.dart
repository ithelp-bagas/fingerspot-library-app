import 'dart:ui';

import 'package:fingerspot_library_app/controllers/auth_controller.dart';
import 'package:fingerspot_library_app/controllers/post_controller.dart';
import 'package:fingerspot_library_app/helpers/api.dart';
import 'package:fingerspot_library_app/helpers/shared_pref.dart';
import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:fingerspot_library_app/views/screens/coming_soon.dart';
import 'package:fingerspot_library_app/views/screens/disimpan/disimpan_screen.dart';
import 'package:fingerspot_library_app/views/screens/diskusi/diskusi_screen.dart';
import 'package:fingerspot_library_app/views/screens/home/home_screen.dart';
import 'package:fingerspot_library_app/views/screens/profile/profile_screen.dart';
import 'package:fingerspot_library_app/views/screens/profile/profile_setting_screen.dart';
import 'package:fingerspot_library_app/views/screens/search/search_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'dart:js' as js;

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});
  final BottomNavController bottomNavController = Get.put(BottomNavController());
  final PostController postController = Get.put(PostController());

  final List<Widget> pages = [
    HomeScreen(),
    SearchScreen(),
    Api.isDebug ? const ComingSoon() : const DiskusiScreen(),
    DisimpanScreen(),
    Api.isDebug ? const ComingSoon() : const ProfileScreen(),
  ];

  final List<String> titles = [
    'Diskusi',
    'Eksplor',
    'Tambah Diskusi',
    'Disimpan',
    'Profil'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Obx(()=> Text(titles[bottomNavController.selectedIndex.value])),
        leading: IconButton(onPressed: (){
            js.context.callMethod('backToMainApp');
        }, icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      body: Obx(() => pages[bottomNavController.selectedIndex.value]),
      bottomNavigationBar: Obx( () => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        currentIndex: bottomNavController.selectedIndex.value,
        onTap: (index) {
          bottomNavController.changeIndex(index);
        },
        unselectedItemColor: Theme.of(context).primaryColorLight,
        selectedItemColor: kPrimary,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.bookOpenVariant),
            label: 'Baca',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Cari',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            label: 'Diskusi',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_add_outlined),
            label: 'Disimpan',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      )),
    );
  }
}

class BottomNavController extends GetxController {
  var selectedIndex = 0.obs;


  @override
  void onInit() async{
    super.onInit();
    await SharedPref().getToken();
  }

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}