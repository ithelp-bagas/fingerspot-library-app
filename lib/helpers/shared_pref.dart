import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  Future<void> storePwa(String pwa) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    preference.setString('pwa', pwa);
  }

  Future<void> storeToken(String token) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('token', token);
  }

  Future<String?> getToken() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.getString('token');
  }

  Future<void> storeEncodedData(String encoded) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('encoded', encoded);
  }

  Future<String?> getEncoded() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.getString('encoded');
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
