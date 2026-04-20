import 'dart:math';
import 'package:flutter/material.dart';

///class for generating and transforming colors.
class ColorGenerator {
  final Random _random = Random();
  static const int _maxValue = 255;

  /// generate random rgb
  Color generateRandom() {
    return Color.fromARGB(
      _maxValue,
      _random.nextInt(_maxValue + 1),
      _random.nextInt(_maxValue + 1),
      _random.nextInt(_maxValue + 1),
    );
  }
  // first I wanted to just invert text color, but it looked not
  // readable in some cases

  // Color invertedColor(Color color) {
  //   return Color.fromARGB(
  //     _maxValue,
  //     (_maxValue - (color.r * _maxValue).round()).clamp(0, _maxValue),
  //     (_maxValue - (color.g * _maxValue).round()).clamp(0, _maxValue),
  //     (_maxValue - (color.b * _maxValue).round()).clamp(0, _maxValue),
  //   );
  // }

  /// pick white or black text color
  static Color getReadableTextColor(Color background) {
    final brightness = ThemeData.estimateBrightnessForColor(background);

    return brightness == Brightness.dark ? Colors.white : Colors.black;
  }
}
