import 'package:flutter/material.dart';
import 'package:lab3/step1.dart';
import 'package:lab3/step2.dart';
import 'package:lab3/step3.dart';
import 'package:lab3/step4.dart';
import './immutable_widget.dart';
import './basic_screen.dart';

void main() => runApp(const StaticApp());

class StaticApp extends StatelessWidget {
  const StaticApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const BasicScreen(),
      // home: const Step4(),
      // home: const Step1(),
      // home: const Step2(),
      // home: const Step3(),
    );
  }
}
