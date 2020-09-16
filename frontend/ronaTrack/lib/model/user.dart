import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class User extends Equatable {
  final int id;
  final String username;
  final String email;
  final AccessToken accessToken;
  final RefreshToken refreshToken;

  const User({
    @required this.email,
    @required this.id,
    @required this.username,
    @required this.accessToken,
    @required this.refreshToken,
  })  : assert(username != null),
        assert(email != null),
        assert(id != null);

  static const empty = User(
      email: '', id: 0, username: '', accessToken: null, refreshToken: null);

  @override
  List<Object> get props => [
        {id, username, accessToken, refreshToken}
      ];

  factory User.fromJson(Map<String, dynamic> data) => User(
      id: data['id'],
      username: data['username'],
      email: data['email'],
      accessToken: AccessToken.fromJson(data),
      refreshToken: RefreshToken.fromJson(data));

  void wipeTokens() {
    this.accessToken.wipeToken();
    this.refreshToken.wipeToken();
  }

  void updateTokens(KeyResponse keyResponse) {
    this.accessToken.updateKey(keyResponse.accessToken);
    this.refreshToken.updateKey(keyResponse.refreshToken);
  }

  Map<String, dynamic> toJson() => {
        "id": this.id,
        "username": this.username,
        "email": this.email,
        "access": this.accessToken.token,
        "refresh": this.refreshToken.token
      };
}

class UserLogin {
  String username;
  String password;

  UserLogin({this.username, this.password});

  Map<String, dynamic> toJson() =>
      {"username": this.username, "password": this.password};
}

class UserCreation {
  String username;
  String password;
  String email;

  UserCreation({this.username, this.password, this.email});

  UserLogin toLogin() {
    UserLogin userLogin =
        UserLogin(username: this.username, password: this.password);
    return userLogin;
  }

  Map<String, dynamic> toJson() => {
        "username": this.username,
        "password": this.password,
        "email": this.email
      };
}

class KeyResponse {
  RefreshToken refreshToken;
  AccessToken accessToken;

  KeyResponse({this.refreshToken, this.accessToken});

  factory KeyResponse.fromJson(Map<String, dynamic> json) {
    return KeyResponse(
        refreshToken: RefreshToken.fromJson(json),
        accessToken: AccessToken.fromJson(json));
  }
  Map<String, dynamic> toJson() =>
      {...this.refreshToken.toJson(), ...this.accessToken.toJson()};
}

abstract class Token {
  String token;

  void wipeToken() {
    this.token = '';
  }

  bool valid() {
    if (this.token == '') {
      return false;
    }
    return true;
  }
}

class RefreshToken extends Token {
  String token;

  RefreshToken({this.token});

  void updateKey(RefreshToken token) {
    this.token = token.token;
  }

  factory RefreshToken.fromJson(Map<String, dynamic> json) {
    return RefreshToken(token: json['refresh']);
  }
  Map<String, dynamic> toJson() => {"refresh": this.token};
}

class AccessToken extends Token {
  String token;

  AccessToken({this.token});
  void updateKey(AccessToken token) {
    this.token = token.token;
  }

  factory AccessToken.fromJson(Map<String, dynamic> json) {
    return AccessToken(token: json['access']);
  }
  Map<String, dynamic> toJson() => {"access": this.token};
}
