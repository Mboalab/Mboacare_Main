import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/user_model.dart';

// TODO:  Just a hack to get user info. Should be removed after implementing sign in using the api
Future<UserModel?> getUserInfo() async {
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request(
      'POST',
      Uri.parse(
          'https://us-central1-mboacare-api-v1.cloudfunctions.net/api/auth/sign-in'));
  request.body =
      json.encode({"email": "kabanda1@gmail.com", "password": "General14@#"});
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final responseBody = await response.stream.bytesToString();
    final responseJson = json.decode(responseBody);

    if (responseJson.containsKey("data")) {
      final userData = responseJson["data"];
      return UserModel(
        uid: userData["uid"],
        email: userData["email"],
        emailVerified: userData["emailVerified"],
        phoneNumber: userData["phoneNumber"],
        displayName: userData["displayName"],
        photoURL: userData["photoURL"],
      );
    }
  }
  return null;
}

// TODO:  There should be a way to do this from server, it's more secure
Future<bool> checkIfUserPasswordIsCorrect() async {
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request(
      'POST',
      Uri.parse(
          'https://us-central1-mboacare-api-v1.cloudfunctions.net/api/auth/sign-in'));
  request.body =
      json.encode({"email": "kabanda1@gmail.com", "password": "General14@#"});
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    return true;
  }
  return false;
}
