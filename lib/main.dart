import 'package:fingerspot_library_app/controllers/auth_controller.dart';
import 'package:fingerspot_library_app/helpers/api.dart';
import 'package:fingerspot_library_app/helpers/shared_pref.dart';
import 'package:fingerspot_library_app/routes/app_pages.dart';
import 'package:fingerspot_library_app/views/constants/color.dart';
import 'package:fingerspot_library_app/views/screens/coming_soon.dart';
import 'package:fingerspot_library_app/views/screens/home/components/shimmer_card.dart';
import 'package:fingerspot_library_app/views/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shimmer/shimmer.dart';


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
        getPages: AppPages.routes,
        theme: lightMode,
        darkTheme: darkMode,
        themeMode: themeMode,
        debugShowCheckedModeBanner: false,
        // home: MainPage(),
        routingCallback: (routing) async {
          // Get the current full URL using Uri.base
          Uri currentUri = Uri.base;

          // Extract the 'data' parameter from the URL
          String? data = currentUri.queryParameters['data'];
          // String? data = Api.encodedData;
          // print('data: $data');

          if (data != null) {
            await SharedPref().storeEncodedData(data);
            String? encoded = await SharedPref().getEncoded();
            String? token = await SharedPref().getToken();
          } else {
            print('No data parameter found in URL');
          }
        },
      ),
    );
  }
}


