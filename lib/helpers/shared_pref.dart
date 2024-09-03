import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  Future<void> storePwa(String pwa) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    preference.setString('pwa', pwa);
  }

  Future<String?> getPwa() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.getString('pwa');
  }

  Future<void> removePwa() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    preference.remove('pwa');
  }
}
