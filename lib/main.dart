import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:pera/src/core/base/base_singleton.dart';
import 'package:pera/src/view/login/login_view.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget with BaseSingleton {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LoginPage(),
      title: constants.appTitle,
      debugShowCheckedModeBanner: constants.debugShowCheckedModeBanner,
      theme: ThemeData(primaryColor: colors.blue),
    );
  }
}
