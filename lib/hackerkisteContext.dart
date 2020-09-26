import 'package:event_view/models/Barcamp.dart';
import 'package:event_view/models/Hackathon.dart';
import 'package:flutter/foundation.dart';

import 'data.dart';
import 'models/Speaker.dart';
import 'models/Talk.dart';

class HackerkisteContext extends ChangeNotifier {
  final data _websiteScraper;

  List<Talk> _talks = [];
  List<Barcamp> _barcamps = [];
  List<Hackathon> _hackathons = [];
  List<Speaker> _speakers = [];

  bool _loading;

  HackerkisteContext():
    _websiteScraper = data()
  {
    _loading = true;
    notifyListeners();

    _websiteScraper.initiate().then((websiteData) {
      this._barcamps = websiteData.barcamps;
      this._hackathons = websiteData.hackathons;
      this._speakers = websiteData.speakers;

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

  List<Hackathon> getHackathons() {
    return _hackathons;
  }

  List<Barcamp> getBarcamps() {
    return _barcamps;
  }

  List<Speaker> getSpeakers() {
    return _speakers;
  }

  bool isLoading() {
    return _loading;
  }
}