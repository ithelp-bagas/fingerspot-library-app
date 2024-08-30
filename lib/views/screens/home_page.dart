import 'package:fingerspot_library_app/helpers/api.dart';
import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:fingerspot_library_app/views/screens/coming_soon.dart';
import 'package:fingerspot_library_app/views/screens/disimpan/disimpan_screen.dart';
import 'package:fingerspot_library_app/views/screens/diskusi/diskusi_screen.dart';
import 'package:fingerspot_library_app/views/screens/home/home_screen.dart';
import 'package:fingerspot_library_app/views/screens/profile/profile_screen.dart';
import 'package:fingerspot_library_app/views/screens/profile/profile_setting_screen.dart';
import 'package:fingerspot_library_app/views/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});
  final BottomNavController bottomNavController = Get.put(BottomNavController());

  final List<Widget> pages = [
    HomeScreen(),
    Api.isDebug ? const ComingSoon() : const SearchScreen(),
    Api.isDebug ? const ComingSoon() : const DiskusiScreen(),
    Api.isDebug ? const ComingSoon() : const DisimpanScreen(),
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
        leading: IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_back_ios_new)),
        actions: [ Obx(() => bottomNavController.selectedIndex.value == 4
            ? IconButton(onPressed: () => Get.to(() => const ProfileSettingScreen()), icon: const Icon(Icons.settings))
            : IconButton(onPressed: (){}, icon: Icon(MdiIcons.heart)))
        ],
      ),
      body: Obx(() => pages[bottomNavController.selectedIndex.value]),
      bottomNavigationBar: Obx( () => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        currentIndex: bottomNavController.selectedIndex.value,
        onTap: (index) {
          bottomNavController.changeIndex(index);
        },
        backgroundColor: kLight,
        unselectedItemColor: kBlack,
        selectedItemColor: kPrimary,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Baca',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Cari',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            label: 'Diskusi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_add_outlined),
            label: 'Disimpan',
          ),
          BottomNavigationBarItem(
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

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}