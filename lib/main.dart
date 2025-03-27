import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:test_fist/routes/ViewClub/ClubListPage.dart';
import 'package:test_fist/routes/ViewClub/ClubMainPage.dart';
import 'package:test_fist/routes/Event%20Release/Event%20Release.dart';
import 'package:test_fist/routes/HomePage.dart';
import 'package:test_fist/routes/Person/PersonPage.dart';

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
      home: const HomePage(),
    );
  }

}

