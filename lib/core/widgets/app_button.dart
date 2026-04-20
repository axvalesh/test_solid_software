import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final VoidCallback callback;
  final Color backgroundColor;
  final Color textColor;
  final Size size;
  final String text;

  const AppButton({
    required this.callback,
    required this.backgroundColor,
    required this.textColor,
    required this.size,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: callback,
        child: Container(
          height: size.height,
          width: size.width,
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}

class Size {
  final double width;
  final double height;

  Size(this.width, this.height);
}
