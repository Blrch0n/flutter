import 'package:flutter/material.dart';
import 'package:lab3/immutable_widget.dart';
import 'package:lab3/step4_2.dart';

class Step4 extends StatelessWidget {
  const Step4({super.key});

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
      body: Column(
        children: const [
          AspectRatio(aspectRatio: 1.0, child: ImmutableWidget()),
          Step42(),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.lightBlue,
          child: const Center(child: Text("I'm a Drawer!")),
        ),
      ),
    );
  }
}
