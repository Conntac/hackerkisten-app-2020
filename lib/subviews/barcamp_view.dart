import 'package:event_view/hackerkisteContext.dart';
import 'package:event_view/subviews/subview.dart';
import 'package:event_view/widgets/event_card/event_card_model.dart';
import 'package:event_view/widgets/event_card/event_card_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BarcampMainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HackerkisteContext>(
        builder: (context, hackerkiste, child) => ListView(
              padding: EdgeInsets.all(4.0),
              children: <Widget>[
                for (var item in hackerkiste.getBarcamps())
                  EventCard.presentation(
                      new Event(
                        item.title,
                        item.description,
                        "",
                      ),
                      item.organizerName,
                      item.organizerCompany,
                      "${item.start.hour}:${item.start.minute} - ${item.end.hour}:${item.end.minute}",
                      item.room,
                      false),
              ],
            ));
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
