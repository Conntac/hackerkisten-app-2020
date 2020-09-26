import 'package:flutter/material.dart';

import 'event_card_model.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final List<CardDescription> details = new List<CardDescription>();
  final bool expanded;

  EventCard(this.event, this.expanded);

  EventCard.presentation(this.event, String speakerName, String organization,
      String time, String room, this.expanded) {
    details
        .add(new CardDescription(Icons.account_circle_outlined, speakerName));
    details.add(new CardDescription(Icons.add_business_outlined, organization));
    details.add(new CardDescription(Icons.access_alarm_outlined, time));
    details.add(new CardDescription(Icons.place_outlined, room));
  }

  EventCard.hackerton(this.event, String contactPerson, String organization,
      String room, this.expanded) {
    details
        .add(new CardDescription(Icons.account_circle_outlined, contactPerson));
    details.add(new CardDescription(Icons.add_business_outlined, organization));
    details.add(new CardDescription(Icons.place_outlined, room));
  }

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

  List<StatelessWidget> _buildList() =>
      details.map((e) => _tile(e.text, e.icon, Colors.grey)).toList();
}

ListTile _tile(String title, IconData icon, Color color) => ListTile(
      title: Text(title),
      leading: Icon(
        icon,
        color: color,
      ),
    );
