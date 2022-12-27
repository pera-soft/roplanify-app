import 'package:flutter/material.dart';
import 'package:pera/src/core/base/base_singleton.dart';
import 'package:pera/src/view/home/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget with BaseSingleton {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Home(),
      title: constants.appTitle,
      debugShowCheckedModeBanner: constants.debugShowCheckedModeBanner,
      theme: ThemeData(primaryColor: colors.blue),
    );
  }
}
