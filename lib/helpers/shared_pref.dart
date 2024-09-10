import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  Future<void> storePwa(String pwa) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    await preference.setString('pwa', pwa);
  }

  Future<void> storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> storeEncodedData(String encoded) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('encoded', encoded);
  }

  Future<String?> getEncoded() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.getString('encoded');
  }

  Future<String?> getPwa() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.getString('pwa');
  }

  Future<void> storeOfficeName(String officeName) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('officeName', officeName);
  }

  Future<String?> getOfficeName() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('officeName');
  }

  Future<void> storeAuthName(String authName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('authName', authName);
  }

  Future<String?> getAuthName() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('authName');
  }

  Future<void> removePwa() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    preference.remove('pwa');
  }
}
