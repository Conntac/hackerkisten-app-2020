import 'package:flutter/foundation.dart';

import 'Talk.dart';

class Hackerkiste extends ChangeNotifier {
  final List<Talk> _talks = [];

  void addTalk(Talk talk) {
    _talks.add(talk);
    notifyListeners();
  }

  List<Talk> getTalks() {
    return _talks;
  }
}