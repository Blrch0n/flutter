import 'package:flutter/material.dart';

class Step1 extends StatelessWidget {
  const Step1({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Container(
          color: Colors.purple,
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Container(color: Colors.blue),
          ),
        ),
      ),
    );
  }
}
