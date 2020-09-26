import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*class EventCardWidget extends StatefulWidget {
  @override
  _EventCardWidgetState createState() => _EventCardWidgetState();
}*/

class EventCard extends StatelessWidget {

  String title;
  String desc;

  EventCard(this.title, this.desc);

  /*EventCard({
    Key key,
  }) : super(key: key);*/

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.album),
            title: Text(title),
            subtitle: Text(desc),
          ),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                child: const Text('Read more'),
                onPressed: () {/* ... */},
              ),
              FlatButton(
                child: const Text('Favorite'), //TODO: Change to star icon
                onPressed: () {/* ... */},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
