import 'package:fingerspot_library_app/controllers/auth_controller.dart';
import 'package:fingerspot_library_app/helpers/shared_pref.dart';
import 'package:fingerspot_library_app/routes/app_pages.dart';
import 'package:fingerspot_library_app/routes/app_routes.dart';
import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';


Future<ThemeMode> getThemeMode() async {
  String? pwaTheme = await SharedPref().getPwa();
  pwaTheme = pwaTheme?.replaceAll('"', '');
  if (pwaTheme == null) {
    return ThemeMode.system; // Return system default if no theme is set
  }
  return pwaTheme == 'light' ? ThemeMode.light : ThemeMode.dark;
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  ThemeMode themeMode = await getThemeMode();
  runApp(MyApp(themeMode: themeMode,));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.themeMode});
  final ThemeMode themeMode;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => GetMaterialApp(
        title: 'Fingerspot Library',
        initialRoute: Routes.MAIN, // Define your initial route here
        getPages: AppPages.routes,
        theme: lightMode,
        darkTheme: darkMode,
        themeMode: themeMode,
        debugShowCheckedModeBanner: false,
        home: MainPage(),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  MainPage({super.key});
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fingerspot Library'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async{
            await authController.login();
            Get.toNamed(Routes.HOME);
          },
          // onPressed: () => Get.toNamed(Routes.ERROR, arguments: {'title': 'Failed'}),
          child: const Text('Open app'),
        ),
      ),
    );
  }
}

