import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

/// The base class for the different types of items the list can contain.
abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildTitle(BuildContext context);

  /// The subtitle line, if any, to show in a list item.
  Widget buildSubtitle(BuildContext context);
}

/// A ListItem that contains data to display a heading.
class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);

  @override
  Widget buildTitle(BuildContext context) {
    return Text(heading, style: Theme.of(context).textTheme.headlineSmall);
  }

  @override
  Widget buildSubtitle(BuildContext context) => const SizedBox.shrink();
}

/// A ListItem that contains data to display a message.
class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);

  @override
  Widget buildTitle(BuildContext context) => Text(sender);

  @override
  Widget buildSubtitle(BuildContext context) => Text(body);
}

final sampleItems = List<ListItem>.generate(
  100,
  (i) => i % 6 == 0
      ? HeadingItem('Heading $i')
      : MessageItem('Sender $i', 'Message body $i'),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Horizontal List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(title: const Text(title), backgroundColor: Colors.red),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  'Simple ListView',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 220,
                child: ListView(
                  children: const <Widget>[
                    ListTile(leading: Icon(Icons.map), title: Text('Map')),
                    ListTile(
                      leading: Icon(Icons.photo_album),
                      title: Text('Album'),
                    ),
                    ListTile(leading: Icon(Icons.phone), title: Text('Phone')),
                  ],
                ),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  'Horizontal ListView',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Container(width: 160, color: Colors.red),
                    Container(width: 160, color: Colors.blue),
                    Container(width: 160, color: Colors.green),
                    Container(width: 160, color: Colors.yellow),
                    Container(width: 160, color: Colors.orange),
                  ],
                ),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  'List with spaced items',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 300,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                          maxHeight: constraints.maxHeight,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Card(
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Center(child: Text('Item 0')),
                                ),
                              ),
                            ),
                            Card(
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Center(child: Text('Item 1')),
                                ),
                              ),
                            ),
                            Card(
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Center(child: Text('Item 2')),
                                ),
                              ),
                            ),
                            Card(
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Center(child: Text('Item 3')),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  'GridView',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                color: Colors.lightBlue,
                child: SizedBox(
                  height: 300,
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: List.generate(6, (index) {
                      return Card(
                        margin: const EdgeInsets.all(8.0),
                        color: Colors.amber,
                        child: Center(
                          child: Text(
                            'Item $index',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  'Work with long lists',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 400,
                child: Builder(
                  builder: (context) {
                    final items = List<String>.generate(10, (i) => 'Item $i');
                    return ListView.builder(
                      itemCount: items.length,
                      // Provide a prototype item to improve performance when all tiles have the same height.
                      prototypeItem: ListTile(title: Text(items.first)),
                      itemBuilder: (context, index) {
                        return ListTile(title: Text(items[index]));
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
