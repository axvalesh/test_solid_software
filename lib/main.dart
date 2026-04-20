import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_solid_software/app.dart';
import 'package:test_solid_software/core/storage/app_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefsShared = await SharedPreferences.getInstance();
  final AppPreferences prefs = AppPreferences(prefsShared);

  runApp(App(prefs: prefs));
}
