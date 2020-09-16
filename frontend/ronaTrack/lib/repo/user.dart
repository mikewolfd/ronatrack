import 'dart:async';
import 'package:ronatrack/model/user.dart';
import 'package:ronatrack/dao/user_dao.dart';

class UserRepository {
  final userDao = UserDao();

  User _user;
  AccessToken _token;

  Future<User> getUser() async {
    if (_user != null) return _user;
    _user = await userDao.getUser();
    return _user;
  }

  Future<bool> hasUser() async {
    return await userDao.hasUser();
  }

  Future<void> storeUser(User user) async {
    // write token with the user to the database
    _user = user;
    await userDao.storeUser(user);
  }

  Future<void> removeUser() async {
    _user = null;
    _token = null;
    await userDao.deleteUser();
  }

  Future<void> deleteToken() async {
    _token = null;
    _user.wipeTokens();
    await storeUser(_user);
  }

  Future<AccessToken> getToken() async {
    if (_token != null) return _token;
    User user = await getUser();
    _token = user.accessToken;
    return _token;
  }

  Future<void> updateToken(AccessToken accessToken) async {
    final user = await getUser();
    user.accessToken.updateKey(accessToken);
    await storeUser(user);
  }

  Future<bool> hasToken() async {
    if (await hasUser()) {
      final user = await getUser();
      return user.accessToken.valid();
    }
    return false;
  }
}
