import 'dart:convert'; // Contains the JSON encoder
import 'package:http/http.dart'; // Contains a client for making API calls
import 'package:html/parser.dart'; // Contains HTML parsers to generate a Document object
import 'package:html/dom.dart';

import 'models/Speaker.dart'; // Contains DOM related classes for extracting data from elements
class data{

  Future initiate() async {
    var client = Client();
    Response response = await client.get('https://2020.hackerkiste.de');
    // zeitplan #speaker .layout-three-images-text > .article-content > div
    // Use html parser
    var document = parse(response.body);
    List<Element> domSpeakers = document.querySelectorAll('#speaker .layout-three-images-text > .article-content > div');
    List<Speaker> speakerList = [];

    for (var domSpeaker in domSpeakers) {
      var img = domSpeaker.querySelector("img");
      var name = domSpeaker.querySelector("h3 > font");
      var organizerName = domSpeaker.querySelector(".open-sans:last > font");
      var speaker = new Speaker();
      speaker.name = name.innerHtml;
      speaker.imageURL = img.attributes["src"];
      speaker.organizerName = organizerName.innerHtml;
      speakerList.add(speaker);
    }

    return speakerList;
  }
}