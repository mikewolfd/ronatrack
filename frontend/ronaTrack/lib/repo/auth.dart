import 'dart:async';

import 'package:meta/meta.dart';
import 'package:ronatrack/api/api_connection.dart';
import 'package:ronatrack/model/user.dart';
import 'package:ronatrack/repo/user.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class SignUpFailure implements Exception {}

class LogInWithUsernameAndPasswordFailure implements Exception {}

/// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}

class AuthenticationRepository {
  AuthenticationRepository({@required UserRepository userRepository})
      : assert(userRepository != null),
        system = userRepository;

  final _controller = StreamController<User>();
  final UserRepository system;

  Stream<User> get user async* {
    if (await system.hasToken()) {
      yield await system.getUser();
    } else {
      yield User.empty;
    }
    yield* _controller.stream;
  }

  Future<void> logIn({
    @required String username,
    @required String password,
  }) async {
    assert(username != null);
    assert(password != null);

    UserLogin userLogin = UserLogin(username: username, password: password);
    try {
      await getToken(userLogin)
          .then((token) => getUser(token))
          .then((user) => {system.storeUser(user), _controller.add(user)});
    } on Exception {
      throw LogInWithUsernameAndPasswordFailure();
    }
  }

  Future<void> registerUser({
    @required String username,
    @required String password,
    @required String email,
  }) async {
    assert(username != null);
    assert(password != null);
    assert(email != null);
    UserCreation userCreation =
        UserCreation(username: username, email: email, password: password);
    try {
      await createUser(userCreation)
          .then((user) => getToken(userCreation.toLogin()))
          .then((token) => getUser(token))
          .then((user) => {system.storeUser(user), _controller.add(user)});
    } on Exception {
      throw SignUpFailure();
    }
  }

  Future<void> logOut() async {
    try {
      await system.deleteToken();
      _controller.add(User.empty);
    } on Exception {
      throw LogOutFailure();
    }
  }
}
