import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ronatrack/model/user.dart';

final _base = "http://127.0.0.1:8000";

Future<KeyResponse> getToken(UserLogin userLogin) async {
  final _tokenEndpoint = "/api/token/";
  final _tokenURL = _base + _tokenEndpoint;
  final http.Response response = await http.post(
    _tokenURL,
    headers: <String, String>{
      'Content-Type': 'application/json',
      'accept': 'application/json'
    },
    body: jsonEncode(userLogin.toJson()),
  );
  if (response.statusCode == 200) {
    return KeyResponse.fromJson(json.decode(response.body));
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}

Future<AccessToken> updateToken(RefreshToken keyResponse) async {
  final _tokenEndpoint = "/api/token/refresh/";
  final _tokenURL = _base + _tokenEndpoint;
  final http.Response response = await http.post(
    _tokenURL,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(keyResponse.toJson()),
  );
  if (response.statusCode == 200) {
    return AccessToken.fromJson(json.decode(response.body));
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}

Future<User> getUser(KeyResponse keyResponse) async {
  final _tokenEndpoint = "/user/update";
  final _tokenURL = _base + _tokenEndpoint;
  final http.Response response = await http.get(
    _tokenURL,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${keyResponse.accessToken.token}'
    },
  );
  if (response.statusCode == 200) {
    User user = User.fromJson(json.decode(response.body));
    user.updateTokens(keyResponse);
    return user;
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}

Future<User> createUser(UserCreation userCreation) async {
  final _tokenEndpoint = "/api/create_user/";
  final _tokenURL = _base + _tokenEndpoint;
  final http.Response response = await http.post(
    _tokenURL,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(userCreation.toJson()),
  );
  if (response.statusCode == 201) {
    User user = User.fromJson(json.decode(response.body));
    return user;
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}
