import 'package:flutter/cupertino.dart';

class Event {
  String title;
  String desc;
  String imgUrl;
  DateTime time;
  String location;
  List<CardDescription> details;
}

class CardDescription {
  Icon icon;
  String text;
}
