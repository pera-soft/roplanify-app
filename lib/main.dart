import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:pera/src/core/base/base_singleton.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pera/src/core/route/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget with BaseSingleton {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      title: constants.appTitle,
      debugShowCheckedModeBanner: constants.debugShowCheckedModeBanner,
      theme: ThemeData(primaryColor: colors.blue),
    );
  }
}
