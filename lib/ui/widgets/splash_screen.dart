import 'package:flutter/material.dart';
import 'package:story_app/common/assets_path.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Image.asset(
          AssetsPath.logoDicodingDark,
          width: 180,
        ),
      ),
    );
  }
}
