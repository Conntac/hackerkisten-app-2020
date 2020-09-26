import 'package:event_view/subviews/subview.dart';
import 'package:event_view/widgets/event_card.dart';
import 'package:flutter/material.dart';

class TalksMainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(4.0),
        children: <Widget>[
          for(int i = 0; i < 6; i++) EventCard("Example Talk ${i + 1}", "I like trains"),
      ],
    );
  }
}

class TalksView extends Subview {
  static TalksView _instance;

  factory TalksView() {
    if (_instance == null) _instance = TalksView._internal();
    return _instance;
  }

  TalksView._internal();

  @override
  Widget mainView() {
    return TalksMainView();
  }

  @override
  Widget bookmarkView() {
    return TalksMainView();
  }
}
