import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_solid_software/core/widgets/app_button.dart';
import 'package:test_solid_software/features/color_changer/presentation/cubit/color_cubit.dart';
import 'package:test_solid_software/features/color_changer/presentation/cubit/color_state.dart';
import 'package:test_solid_software/features/color_changer/presentation/widgets/hint_text.dart';

/// main screen
class ColorScreen extends StatefulWidget {
  /// main screen
  const ColorScreen({super.key});

  @override
  State<ColorScreen> createState() => _ColorScreenState();
}

class _ColorScreenState extends State<ColorScreen> {
  TextEditingController textEditingController = TextEditingController();

  double _horizontalPadding = 30;
  double _verticalPadding = 20;

  void _copyToClipboardHex(String hexText) {
    Clipboard.setData(ClipboardData(text: hexText));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied ${hexText}'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;
    final safePaddingTop = MediaQuery.paddingOf(context).top;
    final safePaddingBottom = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      body: BlocBuilder<ColorCubit, ColorState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  color: state.previousColorBackground,
                  height: height / 2,
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  color: state.colorBackground,
                  height: height / 2,
                ),
              ),

              Positioned(
                bottom: safePaddingBottom + _verticalPadding,
                left: _horizontalPadding,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "${state.tapCount}",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  context.read<ColorCubit>().changeColor();
                },
                onLongPress: () => _copyToClipboardHex(state.hexText),
                child: ColoredBox(
                  color: Colors.transparent,
                  child: SafeArea(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Hello there",
                            style: TextStyle(
                              fontSize: 40,
                              color: state.colorText,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            state.rgbText,
                            style: TextStyle(
                              fontSize: 16,
                              color: state.colorTextPreviousBackground,
                            ),
                          ),
                          Text(
                            state.hexText,
                            style: TextStyle(
                              fontSize: 16,
                              color: state.colorTextPreviousBackground,
                            ),
                          ),
                          HintText(
                            text: "Long press to copy color as hex",
                            duration: const Duration(seconds: 4),
                            style: TextStyle(
                              fontSize: 16,
                              color: state.colorTextPreviousBackground,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                top: safePaddingTop + _verticalPadding,
                left: _horizontalPadding,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: width / 2,
                      color: Colors.white,
                      child: TextField(
                        controller: textEditingController,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          hintText: "#FFFFFF",
                          contentPadding: EdgeInsets.all(5),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),

                    SizedBox(
                      width: 15,
                    ),
                    AppButton(
                      text: "FORCE",
                      callback: () {
                        context.read<ColorCubit>().chageColorToInput(
                          textEditingController.text,
                        );
                        textEditingController.clear();
                      },
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      size: Size(60, 60),
                    ),
                  ],
                ),
              ),

              Positioned(
                bottom: safePaddingBottom + _verticalPadding,
                right: _horizontalPadding,
                child: AppButton(
                  text: "UNDO",
                  callback: () {
                    context.read<ColorCubit>().undoColor();
                  },
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  size: Size(80, 80),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
}
