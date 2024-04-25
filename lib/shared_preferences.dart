// Save level
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveLevel(int level) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('user_level', level);
}

// Retrieve level
Future<int> getLevel() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? value = prefs.getInt('user_level');
  // make getLevel lazy, means if value null, set it to 0 right away
  if (value == null) {
    await saveLevel(1);
    return 1;
  }
  return value;
}

Future<void> incrementLevel() async {
  int newValue = (await getLevel()) + 1;
  debugPrint('incrementing level to $newValue');
  return saveLevel(newValue);
}

Future<void> decrementLevel() async {
  int newValue = (await getLevel()) - 1;
  return saveLevel(newValue);
}

Future<bool> clearLevel() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.clear();
}
