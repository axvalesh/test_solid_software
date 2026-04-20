import 'package:flutter/material.dart';

/// Shows hint and hides after duration
class HintText extends StatefulWidget {
  /// Text
  final String text;

  /// Duration before the hint disappears
  final Duration duration;

  /// Text style
  final TextStyle? style;

  /// TimedHint
  const HintText({
    required this.text,
    required this.duration,
    super.key,
    this.style,
  });

  @override
  State<HintText> createState() => _HintTextState();
}

class _HintTextState extends State<HintText> {
  bool _visible = true;
  bool _removed = false;
  final int _animationDurationInMs = 400;

  @override
  void initState() {
    super.initState();

    Future.delayed(widget.duration, () {
      if (!mounted) return;

      setState(() {
        _visible = false;
      });

      Future.delayed(Duration(milliseconds: _animationDurationInMs), () {
        if (!mounted) return;

        setState(() {
          _removed = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: Duration(milliseconds: _animationDurationInMs),
      child: AnimatedOpacity(
        duration: Duration(milliseconds: _animationDurationInMs),
        opacity: _visible ? 1 : 0,
        child: _removed
            ? const SizedBox.shrink()
            : Text(
                widget.text,
                style: widget.style,
              ),
      ),
    );
  }
}
