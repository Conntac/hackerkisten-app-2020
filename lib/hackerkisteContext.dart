import 'package:event_view/models/Barcamp.dart';
import 'package:flutter/foundation.dart';

import 'data.dart';
import 'models/Talk.dart';

class HackerkisteContext extends ChangeNotifier {
  final data _websiteScraper;

  List<Talk> _talks = [];
  List<Barcamp> _barcamps = [];

  bool _loading;

  HackerkisteContext():
    _websiteScraper = data()
  {
    _loading = true;
    notifyListeners();

    _websiteScraper.initiate().then((websiteData) {
      this._barcamps = websiteData.barcamps;

      _loading = false;
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

  bool isLoading() {
    return _loading;
  }
}