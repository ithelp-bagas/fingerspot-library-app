import 'package:fingerspot_library_app/main.dart';
import 'package:fingerspot_library_app/views/screens/coming_soon.dart';
import 'package:fingerspot_library_app/views/screens/detail/detail_screen.dart';
import 'package:fingerspot_library_app/views/screens/home_page.dart';
import 'package:fingerspot_library_app/views/screens/komentar/komentar_screen.dart';
import 'package:fingerspot_library_app/views/screens/viewers/viewers_screen.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppPages{
  static final routes = [
    GetPage(name: Routes.ERROR, page: () => const ComingSoon()),
    GetPage(name: Routes.MAIN, page: () => MainPage()),
    GetPage(name: Routes.HOME, page: () => MyHomePage()),
    GetPage(name: Routes.DETAIL, page: () => DetailScreen()),
    GetPage(name: Routes.VIEWER, page: () => ViewersScreen()),
    GetPage(name: Routes.KOMENTAR, page: () => KomentarScreen()),
  ];
}