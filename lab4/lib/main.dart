import 'package:flutter/material.dart';
import 'package:lab4/deep_tree.dart';
import 'package:lab4/e_commerce_screen_before.dart';
import 'package:lab4/flex_screen.dart';
import './profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.green,
        appBarTheme: AppBarTheme(
          elevation: 10,
          backgroundColor: Colors.green,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: const TextTheme(
            headlineLarge: TextStyle(fontFamily: 'LeckerliOne', fontSize: 25),
          ).headlineLarge,
        ),
      ),
      // home: ECommerceScreen(),
      // home: const FlexScreen(),
      // home: const DeepTree(),
      home: const ProfileScreen(),
    );
  }
}
