import 'package:flutter/material.dart';
import 'package:lab3/step1.dart';

class Step21 extends StatelessWidget {
  const Step21({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text('Welcome to Flutter'),
        actions: const [
          Padding(padding: EdgeInsets.all(10.0), child: Icon(Icons.edit)),
        ],
      ),
      body: Center(child: AspectRatio(aspectRatio: 1.0, child: Step1())),
      drawer: Drawer(
        child: Container(
          color: Colors.lightBlue,
          child: const Center(child: Text("I'm a Drawer")),
        ),
      ),
    );
  }
}
