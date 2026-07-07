import 'package:flutter/material.dart';
import 'package:taskflow/features/home/screens/home_screen.dart';

class SmartListApp extends StatelessWidget {
  const SmartListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartList',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const HomeScreen(),
    );
  }
}