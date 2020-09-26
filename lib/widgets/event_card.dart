import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final String title;
  final String desc;

  EventCard(this.title, this.desc);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          if (title == "Example Talk 1") // Debugging purposes only
            Image.network(
              'https://lh3.googleusercontent.com/VHB9bVB8cTcnqwnu0nJqKYbiutRclnbGxTpwnayKB4vMxZj8pk1220Rg-6oQ68DwAkqO',
            ),
          ExpansionTile(
            childrenPadding: EdgeInsets.all(8.0),
            initiallyExpanded: title == "Example Talk 1",
            // Change this to first obj in array later
            title: Text(title),
            subtitle: Text(desc),
            children: _buildList(),
          ),
        ],
      ),
    );
  }

  List<StatelessWidget> _buildList() => [
        _tile("Snoopdog's house", Icons.info_outline, Colors.grey),
        _tile('4:20', Icons.access_time, Colors.grey),
        _tile("Snoopdog's house", Icons.place, Colors.grey),
      ];
}

ListTile _tile(String title, IconData icon, Color color) => ListTile(
      title: Text(title),
      leading: Icon(
        icon,
        color: color,
      ),
    );
