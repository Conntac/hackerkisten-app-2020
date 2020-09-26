import 'package:flutter/material.dart';

import 'event_card_model.dart';
import '../favorite_button.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final List<CardDescription> details = new List<CardDescription>();
  final bool expanded;

  EventCard(this.event, this.expanded);

  EventCard.presentation(this.event, String speakerName, String organization,
      String time, String room, this.expanded) {
    details
        .add(new CardDescription(Icons.account_circle, speakerName));
    details.add(new CardDescription(Icons.business, organization));
    details.add(new CardDescription(Icons.access_alarm, time));
    details.add(new CardDescription(Icons.place, room));
  }

  EventCard.hackerton(this.event, String contactPerson, String organization,
      String room, this.expanded) {
    details
        .add(new CardDescription(Icons.account_circle, contactPerson));
    details.add(new CardDescription(Icons.business, organization));
    details.add(new CardDescription(Icons.place, room));
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
            leading: FavoriteButton(event.title),
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
