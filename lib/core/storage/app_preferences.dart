import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  final SharedPreferences _prefs;

  static const String _lastColor = "last_color";

  AppPreferences(this._prefs);

  Future<void> saveLastColor(int newColor) async {
    await _prefs.setInt(_lastColor, newColor);
  }

  Future<int?> getLastColor() async => _prefs.getInt(_lastColor);
}
