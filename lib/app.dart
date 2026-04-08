import 'package:flutter/material.dart';
import 'package:test_solid_software/features/color_changer/presentation/color_screen.dart';

/// entry point
class App extends StatelessWidget {
  /// entry point
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Test Task',
      debugShowCheckedModeBanner: false,
      home: ColorScreen(),
    );
  }
}
