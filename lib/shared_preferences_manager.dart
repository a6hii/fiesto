import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
//Unique key that can be used to identify is feshly installed flag
  static const String isFreshlyInstalledPreferenceKey = "is_freshly_installed";

  Future<bool> isFreshInstalled() async {
    var pref = await SharedPreferences.getInstance();
    bool? isFreshlyInstalled = pref.getBool(isFreshlyInstalledPreferenceKey);
    if (isFreshlyInstalled == null) {
//null means if fresh installed and flag wasn't stored before
//so we save false into pref incase this flag is needed again or else where after fresh installation
      return await pref.setBool(isFreshlyInstalledPreferenceKey, false);
    } else {
      return isFreshlyInstalled;
    }
  }
}
