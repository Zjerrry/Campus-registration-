import 'dart:developer';

import 'package:flutter/material.dart';
import 'routes/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Club_Activity_App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true
      ),
      home: const HomePageRoute(),
      routes: <String,WidgetBuilder>{},
    );
  }

}

