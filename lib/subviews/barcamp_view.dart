import 'package:event_view/subviews/subview.dart';
import 'package:flutter/material.dart';

class BarcampMainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.blue);
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
