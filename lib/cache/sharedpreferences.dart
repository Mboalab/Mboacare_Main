import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;

class SharedPreference extends ChangeNotifier {
  static const String isSignedIn = 'isSignedIn';
  final String emailKey = 'user_email';
  final String passwordKey = 'password';


  /// clear shared preferences
  Future<void> clear() async {
    prefs = await SharedPreferences.getInstance();
    await prefs!.clear();
  }

  /// cache user signed in
  saveIsSignedIn(bool id) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setBool(isSignedIn, id);
    notifyListeners();
  }
  /// get user signed in
  Future<bool> getIsSignedIn() async {
    prefs = await SharedPreferences.getInstance();
    return prefs!.getBool(isSignedIn) ?? false;
  }

  /// cache user email
  saveEmail(String id) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setString(emailKey, id);
    notifyListeners();
  }
  /// remove cache user email
  removeSaveEmail() async {
    prefs = await SharedPreferences.getInstance();
    prefs!.remove(emailKey);
    notifyListeners();
  }
  /// get user email
  Future<String> getEmail() async {
    prefs = await SharedPreferences.getInstance();
    return prefs!.getString(emailKey) ?? '';
  }

}
