import 'package:event_view/subviews/subview.dart';
import 'package:event_view/widgets/event_card/event_card_model.dart';
import 'package:event_view/widgets/event_card/event_card_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../hackerkisteContext.dart';

class HackathonMainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*return ListView(
      padding: EdgeInsets.all(4.0),
      children: <Widget>[
        for (int i = 0; i < 6; i++)
          EventCard.hackerton(
              new Event(
                "Hackerton ${i + 1}",
                "I like trains",
                'https://lh3.googleusercontent.com/VHB9bVB8cTcnqwnu0nJqKYbiutRclnbGxTpwnayKB4vMxZj8pk1220Rg-6oQ68DwAkqO',
              ),
              "Speaker",
              "Testfirma",
              "Raum 1",
              i == 0),
      ],
    );*/
    return Consumer<HackerkisteContext>(
        builder: (context, hackerkiste, child) => ListView(
          padding: EdgeInsets.all(4.0),
          children: <Widget>[
            for (var item in hackerkiste.getHackathons())
              EventCard.hackerton(
                  new Event(
                    item.title ?? "",
                    item.description ?? "",
                    "",
                  ),
                  item.organizerCompany ?? "",
                  item.organizerName ?? "",
                  item.room ?? "",
                  false),
          ],
        ));
  }
}

class HackathonView extends Subview {
  static HackathonView _instance;

  factory HackathonView() {
    if (_instance == null) _instance = HackathonView._internal();
    return _instance;
  }

  HackathonView._internal();

  @override
  Widget mainView() {
    return HackathonMainView();
  }

  @override
  Widget bookmarkView() {
    return HackathonMainView();
  }
}
