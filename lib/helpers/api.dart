class Api {
  Api._();

  static const String runMode = 'web';

  static late String defaultUrl;
  static late String baseUrl;
  static late String imgurl;
  static late String encodedData;

  // Default profile image
  static const String defaultProfile = 'https://static.vecteezy.com/system/resources/previews/014/194/215/original/avatar-icon-human-a-person-s-badge-social-media-profile-symbol-the-symbol-of-a-person-vector.jpg';

  static const bool isDebug = true;

  // Initialize the API with the correct environment based on the mode
  static void initializeApi(String mode) {
    switch (mode) {
      case 'prod':
      // Production environment
        defaultUrl = 'http://library.fingerspot.net';
        baseUrl = '$defaultUrl/api';
        imgurl = '$defaultUrl/';
        encodedData = 'FINfQ==c2VyX2lkIjozNjQ3MywidHlwZSI6MiwiY29tcGFueV9pZCI6MTI3NzYsInBhY2thZ2VfaWQiOjYsImVtcF9pZCI6OTk3ODUsImVtcF9waW4iOiIxIiwibW9kdWxlX2lkIjozLCJpcF9hZGRyZXNzIjoiMTkyLjE2OC4xLjkxIiwicGxhdGZvcm0iOiJhbmRyb2lkIiwibGFuZ3VhZ2UiOiJpZCIsInRoZW1lIjoibGlnaHQiLCJlbWFpbCI6ImFkbWluQG15c2ltcGxlc29mdC5jb20ieyJ1SPOT';
        break;

      case 'dev-of':
      // Environment for PC Mas Heru
        defaultUrl = 'http://192.168.1.150:81/lib';
        baseUrl = '$defaultUrl/api';
        imgurl = '$defaultUrl/';
        encodedData = 'FINfQ==c2VyX2lkIjozNjQ3MywidHlwZSI6MiwiY29tcGFueV9pZCI6MTI3NzYsInBhY2thZ2VfaWQiOjYsImVtcF9pZCI6OTk3ODUsImVtcF9waW4iOiIxIiwibW9kdWxlX2lkIjozLCJpcF9hZGRyZXNzIjoiMTkyLjE2OC4xLjkxIiwicGxhdGZvcm0iOiJhbmRyb2lkIiwibGFuZ3VhZ2UiOiJpZCIsInRoZW1lIjoibGlnaHQiLCJlbWFpbCI6ImhlcnUuZmluZ2Vyc3BvdEBnbWFpbC5jb20ieyJ1SPOT';
        break;

      case 'dev':
      default:
      // Local development environment
        defaultUrl = 'http://192.168.1.141/fingerspot-library';
        baseUrl = '$defaultUrl/api';
        imgurl = '$defaultUrl/';
        // encodedData = 'FINfQ==c2VyX2lkIjogMzY0NzMsInR5cGUiOiAyLCJjb21wYW55X2lkIjogMTI3NzYsInBhY2thZ2VfaWQiOiA2LCJlbXBfaWQiOiA5OTc4NSwiZW1wX3BpbiI6ICIxIiwibW9kdWxlX2lkIjogMywiaXBfYWRkcmVzcyI6ICIxOTIuMTY4LjEuOTEiLCJwbGF0Zm9ybSI6ICJhbmRyb2lkIiwibGFuZ3VhZ2UiOiAiZW4iLCJ0aGVtZSI6ICJsaWdodCIsImVtYWlsIjogImhlcnUuZmluZ2Vyc3BvdEBnbWFpbC5jb20ieyJ1SPOT';
        encodedData = 'FINfQ==c2VyX2lkIjogMzY0NzMsInR5cGUiOiAyLCJjb21wYW55X2lkIjogMTI3NzYsInBhY2thZ2VfaWQiOiA2LCJlbXBfaWQiOiA5OTc4NSwiZW1wX3BpbiI6ICIxIiwibW9kdWxlX2lkIjogMywiaXBfYWRkcmVzcyI6ICIxOTIuMTY4LjEuOTEiLCJwbGF0Zm9ybSI6ICJhbmRyb2lkIiwibGFuZ3VhZ2UiOiAiZW4iLCJ0aGVtZSI6ICJsaWdodCIsImVtYWlsIjogImhlcnUuZmluZ2Vyc3BvdEBnbWFpbC5jb20ieyJ1SPOT';
        break;
    }
  }
}
