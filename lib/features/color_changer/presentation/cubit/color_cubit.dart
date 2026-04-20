import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_solid_software/core/storage/app_preferences.dart';
import 'package:test_solid_software/features/color_changer/domain/services/color_formatter.dart';
import 'package:test_solid_software/features/color_changer/domain/services/color_generator.dart';
import 'package:test_solid_software/features/color_changer/presentation/cubit/color_state.dart';

class ColorCubit extends Cubit<ColorState> {
  final ColorGenerator _colorGenerator;
  final AppPreferences _prefs;
  static const int _colorHistoryLength = 10;

  ColorCubit(this._prefs, this._colorGenerator)
    : super(
        const ColorState(
          colorBackground: Colors.white,
          colorHistory: [Colors.white],
          tapCount: 0,
          isLoading: true,
        ),
      );

  Future<void> init() async {
    try {
      await loadSavedColor();
    } catch (e, s) {
      print('Failed to init ColorCubit: $e');
      debugPrintStack(stackTrace: s);
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> loadSavedColor() async {
    int? savedColorValue = await _prefs.getLastColor();

    if (savedColorValue == null) return;

    final color = Color(savedColorValue);
    _updateColorState(color, newHistory: [Colors.white, color]);
  }

  void chageColorToInput(String input) {
    Color? newColor = ColorFormatter.formatHexFromText(input);
    if (newColor == null) return;

    _updateColorState(newColor);
  }

  Future<void> changeColor() async {
    Color newColor = _colorGenerator.generateRandom();
    if (newColor == state.colorBackground) {
      changeColor();

      return;
    }

    _updateColorState(newColor, incrementTapCount: true);
    print(state.colorHistory);
    print(state.colorHistory.length);

    await _prefs.saveLastColor(newColor.value);
  }

  void undoColor() {
    if (state.colorHistory.length < ColorState.beforeLastIndex) return;

    final List<Color> newHistory = List.of(state.colorHistory)..removeLast();
    final Color newColor = newHistory.last;

    _updateColorState(newColor, newHistory: newHistory);
  }

  List<Color> _addColorToHistory(List<Color> colorHistory, Color newColor) {
    final List<Color> newColorHistory = [...colorHistory];
    if (colorHistory.length == _colorHistoryLength) {
      newColorHistory.removeAt(0);
    }

    newColorHistory.add(newColor);

    return newColorHistory;
  }

  void _updateColorState(
    Color newColor, {
    List<Color>? newHistory,
    bool incrementTapCount = false,
  }) {
    emit(
      state.copyWith(
        colorBackground: newColor,
        colorHistory:
            newHistory ?? _addColorToHistory(state.colorHistory, newColor),
        tapCount: incrementTapCount ? state.tapCount + 1 : state.tapCount,
      ),
    );
  }
}
