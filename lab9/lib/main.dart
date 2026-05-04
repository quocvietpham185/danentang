// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/loading_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(), // Dùng nền tối
      home: const LoadingScreen(), // Màn hình đầu tiên là LoadingScreen
    );
  }
}
