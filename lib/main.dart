import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:test_fist/routes/HomePage.dart';
import 'package:test_fist/commons/Global.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  await Global.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412,917),
      minTextAdapt: true,


      
      splitScreenMode: true,
      builder: (context,child)=>MaterialApp(
        //debugShowCheckedModeBanner: false,
        title: '线上报名',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true
        ),
        home: child
      ),
      child: const HomePage(),

    );

  }

}
/*
MaterialApp(
      title: 'Club_Activity_App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true
      ),
      home: const HomePage(),
    );
 */
