import 'package:flutter/material.dart';

class matches extends StatelessWidget {
  const matches({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('week 31')),
      body: ListView(
        children: const <Widget>[
          ListTile(
            title: Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(child: Text('A')),
                      Text('Headline'),
                      Text('Supporting text'),
                      Icon(Icons.favorite_rounded),
                    ],
                  )
                ],
              ),
            ),

          ),
          Divider(height: 0),
          ListTile(
            leading: CircleAvatar(child: Text('B')),
            title: Text('Headline'),
            subtitle: Text(
                'Longer supporting text to demonstrate how the text wraps and how the leading and trailing widgets are centered vertically with the text.'),
            trailing: Icon(Icons.favorite_rounded),
          ),
          Divider(height: 0),
          ListTile(
            leading: CircleAvatar(child: Text('C')),
            title: Text('Headline'),
            subtitle: Text(
                "Longer supporting text to demonstrate how the text wraps and how setting 'ListTile.isThreeLine = true' aligns leading and trailing widgets to the top vertically with the text."),
            trailing: Icon(Icons.favorite_rounded),
            isThreeLine: true,
          ),
          Divider(height: 0),
        ],
      ),
    );
  }
}

