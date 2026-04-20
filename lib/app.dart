import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_solid_software/core/storage/app_preferences.dart';
import 'package:test_solid_software/features/color_changer/domain/services/color_generator.dart';
import 'package:test_solid_software/features/color_changer/presentation/color_screen.dart';
import 'package:test_solid_software/features/color_changer/presentation/cubit/color_cubit.dart';

/// entry point
class App extends StatelessWidget {
  final AppPreferences prefs;

  /// entry point
  App({super.key, required this.prefs});

  final ColorGenerator colorGenerator = ColorGenerator();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Test Task',
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => ColorCubit(prefs, colorGenerator)..init(),
        child: ColorScreen(),
      ),
    );
  }
}
