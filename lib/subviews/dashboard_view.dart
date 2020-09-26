import 'package:event_view/subviews/subview.dart';
import 'package:flutter/material.dart';

class DashboardMainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Image.asset('assets/title.jpg'),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Expanded(
              child: Center(
                child: Text(
                    "Willkommen in der Hackerkisten App",
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}

class DashboardView extends Subview {
  static DashboardView _instance;

  factory DashboardView() {
    if (_instance == null) _instance = DashboardView._internal();
    return _instance;
  }

  DashboardView._internal();

  @override
  Widget mainView() {
    return DashboardMainView();
  }

  @override
  Widget bookmarkView() {
    return DashboardMainView();
  }
}
