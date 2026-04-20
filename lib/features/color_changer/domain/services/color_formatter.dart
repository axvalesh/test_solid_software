import 'dart:ui';

final class ColorFormatter {
  static const int _maxValue = 255;
  static const int _hexBase = 16;
  static const int _hexLength = 2;

  static int _to255(double value) {
    return (value * _maxValue).round();
  }

  /// text representation color as rgb
  static String formatRgbToText(Color color) {
    final r = _to255(color.r);
    final g = _to255(color.g);
    final b = _to255(color.b);

    return 'RGB($r, $g, $b)';
  }

  /// text representation color as hex
  static String formatHexToText(Color color) {
    final r = _to255(color.r);
    final g = _to255(color.g);
    final b = _to255(color.b);

    return '#'
        '${r.toRadixString(_hexBase).padLeft(_hexLength, '0').toUpperCase()}'
        '${g.toRadixString(_hexBase).padLeft(_hexLength, '0').toUpperCase()}'
        '${b.toRadixString(_hexBase).padLeft(_hexLength, '0').toUpperCase()}';
  }

  static Color? formatHexFromText(String hex) {
    int hexSuitableLength = 6;
    final cleanedHex = hex.replaceAll('#', '').trim();

    if (cleanedHex.length != hexSuitableLength) return null;

    final colorInt = int.tryParse('FF$cleanedHex', radix: 16);
    if (colorInt == null) return null;

    return Color(colorInt);
  }
}
