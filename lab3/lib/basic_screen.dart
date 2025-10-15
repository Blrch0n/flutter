import 'package:flutter/material.dart';
import 'package:lab3/immutable_widget.dart';
import 'package:lab3/text_layout.dart';

class BasicScreen extends StatelessWidget {
  const BasicScreen({super.key});

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Semantics(
            image: true,
            label: 'Beautiful wallpaper background',
            child: Image.asset('assets/wallpaper.jpg'),
          ),
          const TextLayout(),
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: const [
              ExpansionTile(
                title: Text('List 1'),
                children: [
                  ListTile(title: Text('Item 1')),
                  ListTile(title: Text('Item 2')),
                  ListTile(title: Text('Item 3')),
                ],
              ),
              ExpansionTile(
                title: Text('List 2'),
                children: [
                  ListTile(title: Text('Item 4')),
                  ListTile(title: Text('Item 5')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
