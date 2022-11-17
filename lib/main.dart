import 'package:dalle_flutter_mobile_app/features/onboarding/view/onboarding_view.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/init/theme/ligth/app_theme_ligth.dart';

Future<void> main() async {
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter DALL-E',
      debugShowCheckedModeBanner: false,
      theme: AppThemeLight.instance.theme,
      home: const OnBoardingView(),
    );
  }
}
