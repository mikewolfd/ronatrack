import 'package:ronatrack/model/user.dart';
import 'package:ronatrack/dao/db.dart';
import 'dart:convert';

class UserDao extends Dao {
  final _userKey = 'user';

  Future<void> storeUser(User user) async {
    final prefs = await getDb();
    prefs.setString(_userKey, json.encode(user.toJson()));
  }

  Future<void> deleteUser() async {
    final prefs = await getDb();
    prefs.remove(_userKey);
  }

  Future<bool> hasUser() async {
    final prefs = await getDb();
    return prefs.containsKey(_userKey);
  }

  Future<User> getUser() async {
    final prefs = await getDb();
    final user = prefs.getString(_userKey);
    User _user = User.fromJson(json.decode(user));
    return _user;
  }
}
