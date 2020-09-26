import 'package:flutter/cupertino.dart';

class Event {
  String title;
  String desc;
  String imgUrl;
  //List<CardDescription> details;

  Event(this.title, this.desc, this.imgUrl);
}

class CardDescription {
  IconData icon;
  String text;

  CardDescription(this.icon, this.text);
}
