import 'package:event_view/subviews/subview.dart';
import 'package:flutter/material.dart';

class HackathonMainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.green);
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
