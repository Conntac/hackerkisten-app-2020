import 'package:event_view/subviews/barcamp_view.dart';
import 'package:event_view/subviews/hackathon_view.dart';
import 'package:event_view/subviews/subview.dart';
import 'package:event_view/subviews/talks_view.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _DrawerItem {
  final String title;
  final IconData icon;
  final Subview view;

  const _DrawerItem(this.title, this.icon, this.view);
}

class _MainViewState extends State<MainView> {
  final _drawerItems = [
    _DrawerItem("Talks", Icons.person, TalksView()),
    _DrawerItem("Hackathons", Icons.computer, HackathonView()),
    _DrawerItem("Barcamps", Icons.local_bar, BarcampView())
  ];

  Subview _currentSubview;
  String _currentTitle;

  _MainViewState() {
    _currentSubview = _drawerItems.first.view;
    _currentTitle = _drawerItems.first.title;
  }

  Widget _makeDrawerTile({BuildContext context, _DrawerItem drawerItem}) =>
      ListTile(
        leading: Icon(drawerItem.icon),
        title: Text(drawerItem.title),
        onTap: () {
          Navigator.of(context).pop();
          setState(() {
            _currentSubview = drawerItem.view;
            _currentTitle = drawerItem.title;
          });
        },
      );

  Widget get _currentMainView => _currentSubview.mainView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_currentTitle),
          actions: [
            IconButton(
              icon: Icon(Icons.bookmark_border),
              onPressed: () {},
            )
          ],
        ),
        drawer: Drawer(
          child: Column(
            children: [
              buildDrawerHeader(),
              ..._drawerItems.map((drawerItem) =>
                  _makeDrawerTile(context: context, drawerItem: drawerItem)),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    child: Text(
                      'Entstanden 2020 im Hackathon\nder Conntac GmbH',
                      style: Theme.of(context).textTheme.caption.apply(
                          color: Theme.of(context)
                              .textTheme
                              .caption
                              .color
                              .withAlpha(50)),
                      textAlign: TextAlign.center,
                    ),
                    padding: EdgeInsets.all(10),
                  ),
                ),
              )
            ],
          ),
        ),
        body: _currentMainView);
  }

  DrawerHeader buildDrawerHeader() {
    return DrawerHeader(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.amber, Colors.blue],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      child: Center(
        child: Image(
          image: AssetImage('assets/hackerkiste_logo.png'),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
