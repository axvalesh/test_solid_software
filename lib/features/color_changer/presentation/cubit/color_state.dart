import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:test_solid_software/features/color_changer/domain/services/color_formatter.dart';
import 'package:test_solid_software/features/color_changer/domain/services/color_generator.dart';

final class ColorState extends Equatable {
  final Color colorBackground;
  final List<Color> colorHistory;
  final int tapCount;
  final bool isLoading;

  static const beforeLastIndex = 2;

  Color get previousColorBackground => colorHistory.length >= beforeLastIndex
      ? colorHistory[colorHistory.length - beforeLastIndex]
      : Colors.white;

  String get hexText => ColorFormatter.formatHexToText(colorBackground);
  String get rgbText => ColorFormatter.formatRgbToText(colorBackground);
  Color get colorText => ColorGenerator.getReadableTextColor(colorBackground);
  Color get colorTextPreviousBackground =>
      ColorGenerator.getReadableTextColor(previousColorBackground);

  @override
  List<Object?> get props => [
    colorBackground,
    colorHistory,
    tapCount,
    isLoading,
  ];

  const ColorState({
    required this.colorBackground,
    required this.colorHistory,
    required this.tapCount,
    required this.isLoading,
  });

  ColorState copyWith({
    Color? colorBackground,
    Color? colorText,
    List<Color>? colorHistory,
    int? colorHistoryLength,
    int? tapCount,
    bool? isLoading,
  }) {
    return ColorState(
      colorBackground: colorBackground ?? this.colorBackground,
      colorHistory: colorHistory ?? this.colorHistory,
      tapCount: tapCount ?? this.tapCount,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
