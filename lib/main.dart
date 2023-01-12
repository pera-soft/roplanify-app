import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:pera/src/core/base/base_singleton.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pera/src/view/splash/view/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget with BaseSingleton {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen(),
      title: constants.appTitle,
      debugShowCheckedModeBanner: constants.debugShowCheckedModeBanner,
      theme: ThemeData(primaryColor: colors.blue),
    );
  }
}
