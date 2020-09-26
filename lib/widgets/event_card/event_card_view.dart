import 'package:flutter/material.dart';

import 'event_card_model.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final bool expanded;

  EventCard(this.event, this.expanded);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          if (event.imgUrl != null && event.imgUrl.isNotEmpty)
            Image.network(event.imgUrl),
          ExpansionTile(
            childrenPadding: EdgeInsets.all(8.0),
            initiallyExpanded: expanded,
            title: Text(event.title),
            subtitle: Text(event.desc),
            children: _buildList(),
          ),
        ],
      ),
    );
  }

  List<StatelessWidget> _buildList() => [
        _tile(event.details, Icons.info_outline, Colors.grey),
        _tile(event.time.toString(), Icons.access_time, Colors.grey),
        _tile(event.location, Icons.place, Colors.grey),
      ];
}

ListTile _tile(String title, IconData icon, Color color) => ListTile(
      title: Text(title),
      leading: Icon(
        icon,
        color: color,
      ),
    );
