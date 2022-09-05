import 'package:flutter/material.dart';
import 'package:maleapp/presentation/theme_manger.dart';

class MyApp extends StatefulWidget {

  MyApp._internal();
  static final MyApp instance=MyApp._internal();
  factory MyApp()=>instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getApplicationTheme(),
    );
  }
}
