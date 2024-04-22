// Save level
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveLevel(int level) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('user_level', level);
}

// Retrieve level
Future<int?> getLevel() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt('user_level');
}

Future<bool> clearLevel() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.clear();
}
