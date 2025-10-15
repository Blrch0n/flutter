import 'package:flutter/material.dart';

class Step42 extends StatelessWidget {
  const Step42({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Hello, World!', style: TextStyle(fontSize: 16)),
        Text(
          'Text can wrap without issue',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        //make sure the Text below is all in one line:
        const Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam at mauris massa. Suspendisse potenti. Aenean aliquet eu nisl vitae tempus.',
        ),
      ],
    );
  }
}
