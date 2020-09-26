import 'package:event_view/subviews/subview.dart';
import 'package:event_view/widgets/event_card/event_card_model.dart';
import 'package:event_view/widgets/event_card/event_card_view.dart';
import 'package:flutter/material.dart';

class BarcampMainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(4.0),
      children: <Widget>[
        for (int i = 0; i < 6; i++)
          EventCard.presentation(
              new Event(
                "Example Talk ${i + 1}",
                "I like trains",
                'https://lh3.googleusercontent.com/VHB9bVB8cTcnqwnu0nJqKYbiutRclnbGxTpwnayKB4vMxZj8pk1220Rg-6oQ68DwAkqO',
              ),
              "Speaker",
              "Testfirma",
              "09:00 - 10:00",
              "Raum 1",
              i == 0),
      ],
    );
  }
}

class BarcampView extends Subview {
  static BarcampView _instance;

  factory BarcampView() {
    if (_instance == null) _instance = BarcampView._internal();
    return _instance;
  }

  BarcampView._internal();

  @override
  Widget mainView() {
    return BarcampMainView();
  }

  @override
  Widget bookmarkView() {
    return BarcampMainView();
  }
}
