import 'package:shared_preferences/shared_preferences.dart';

class Dao {
  Future<SharedPreferences> getDb() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    return prefs;
  }
}
