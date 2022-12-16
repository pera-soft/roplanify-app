import 'package:flutter/material.dart';
import 'package:pera/src/view/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const Home(),
      title: "Roplanify",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.blue),);
  }
}

