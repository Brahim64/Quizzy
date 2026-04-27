import 'dart:convert';
import 'package:quizzy/models/player.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLocalStorage {
  static const _keyUser = "quiz_user_profile";

  static Future<void> saveUser(Player user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUser, jsonEncode(user.toJson()));
  }

  static Future<Player?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_keyUser);

    if (data == null) return null;

    return Player.fromJson(jsonDecode(data));
  }

  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUser);
  }
}