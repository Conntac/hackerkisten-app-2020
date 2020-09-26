import 'package:event_view/models/Barcamp.dart';
import 'package:flutter/foundation.dart';

import '../data.dart';
import 'Talk.dart';

class Hackerkiste extends ChangeNotifier {
  final data _dataProvider;

  List<Talk> _talks = [];
  List<Barcamp> _barcamps = [];

  Hackerkiste():
    _dataProvider = data()
  {
      _dataProvider.initiate().then((websiteData) {
        this._barcamps = websiteData.barcamps;

        this.notifyListeners();
      });
  }

  void addTalk(Talk talk) {
    _talks.add(talk);
    notifyListeners();
  }

  List<Talk> getTalks() {
    return _talks;
  }

  List<Barcamp> getBarcamps() {
    return _barcamps;
  }
}