import 'package:event_view/data.dart';
import 'package:event_view/hackerkisteContext.dart';
import 'package:event_view/models/Talk.dart';
import 'package:event_view/subviews/subview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TalksMainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HackerkisteContext>(
      builder: (context, hackerkiste, child) {
        data d = data();
        return Container(color: Colors.red,
        child: Stack(
          children: [
            Text("Number of barcamps: ${hackerkiste.getBarcamps().length}; still loading? ${hackerkiste.isLoading()}"),
            FlatButton(color: Colors.blue, onPressed: () => {
              //hackerkiste.addTalk(Talk())
              d.initiate()
            }, child: Text("Add talk"))
          ])
        );
      }
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
