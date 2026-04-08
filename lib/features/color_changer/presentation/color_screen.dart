import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_solid_software/features/color_changer/domain/color_generator.dart';
import 'package:test_solid_software/features/color_changer/presentation/widgets/hint_text.dart';

/// main screen
class ColorScreen extends StatefulWidget {
  /// main screen
  const ColorScreen({super.key});

  @override
  State<ColorScreen> createState() => _ColorScreenState();
}

class _ColorScreenState extends State<ColorScreen> {
  final ColorGenerator colorGenerator = ColorGenerator();
  Color _colorBackground = Colors.white;
  Color _colorText = Colors.black;
  String get rgbText => colorGenerator.formatRgb(_colorBackground);
  String get hexText => colorGenerator.formatHex(_colorBackground);

  void _changeColor() {
    setState(() {
      _colorBackground = colorGenerator.generateRandom();
      _colorText = colorGenerator.getReadableTextColor(_colorBackground);
    });
  }

  void _copyToClipboardHex() {
    Clipboard.setData(ClipboardData(text: hexText));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied $hexText'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _changeColor,
        onLongPress: _copyToClipboardHex,
        child: ColoredBox(
          color: _colorBackground,
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Hello there",
                    style: TextStyle(
                      fontSize: 40,
                      color: _colorText,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    rgbText,
                    style: TextStyle(
                      fontSize: 16,
                      color: _colorText,
                    ),
                  ),
                  Text(
                    hexText,
                    style: TextStyle(
                      fontSize: 16,
                      color: _colorText,
                    ),
                  ),
                  HintText(
                    text: "Long press to copy color as hex",
                    duration: const Duration(seconds: 4),
                    style: TextStyle(
                      fontSize: 16,
                      color: _colorText,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
