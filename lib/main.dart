import 'package:event_view/mainView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/Hackerkiste.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // enable fullscreen
    // SystemChrome.setEnabledSystemUIOverlays([]);
    
    // TODO: Replace with MultiProivder to have one state per model (barcamp, hackathon, etc..)
    return ChangeNotifierProvider(create: (context) => Hackerkiste(),
    child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MainView(),
        debugShowCheckedModeBanner: true
      )
    );
  }
}
