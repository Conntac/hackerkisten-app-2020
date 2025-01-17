import 'package:event_view/data.dart';
import 'package:event_view/hackerkisteContext.dart';
import 'package:event_view/models/Talk.dart';
import 'package:event_view/subviews/subview.dart';
import 'package:event_view/widgets/event_card/event_card_view.dart';
import 'package:event_view/widgets/event_card/event_card_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TalksMainView extends StatelessWidget {
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
