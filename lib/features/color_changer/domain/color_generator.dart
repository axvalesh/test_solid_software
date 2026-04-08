import 'dart:math';
import 'package:flutter/material.dart';

///class for generating and transforming colors.
class ColorGenerator {
  final Random _random = Random();
  static const int _maxValue = 255;
  static const int _hexBase = 16;
  static const int _hexLength = 2;

  int _to255(double value) => (value * _maxValue).round();

  /// generate random rgb
  Color generateRandom() {
    return Color.fromARGB(
      _maxValue,
      _random.nextInt(_maxValue + 1),
      _random.nextInt(_maxValue + 1),
      _random.nextInt(_maxValue + 1)
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
  Color getReadableTextColor(Color background) {
    final brightness = ThemeData.estimateBrightnessForColor(background);

    return brightness == Brightness.dark
        ? Colors.white
        : Colors.black;
  }

  /// text representation color as rgb
  String formatRgb(Color color) {
    final r = _to255(color.r);
    final g = _to255(color.g);
    final b = _to255(color.b);

    return 'RGB($r, $g, $b)';
  }

  /// text representation color as hex
  String formatHex(Color color) {
  final r = _to255(color.r);
  final g = _to255(color.g);
  final b = _to255(color.b);

    return '#'
        '${r.toRadixString(_hexBase).padLeft(_hexLength, '0').toUpperCase()}'
        '${g.toRadixString(_hexBase).padLeft(_hexLength, '0').toUpperCase()}'
        '${b.toRadixString(_hexBase).padLeft(_hexLength, '0').toUpperCase()}';
  }
}
