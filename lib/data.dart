import 'dart:convert'; // Contains the JSON encoder
import 'package:event_view/models/Barcamp.dart';
import 'package:event_view/models/Hackathon.dart';
import 'package:http/http.dart'; // Contains a client for making API calls
import 'package:html/parser.dart'; // Contains HTML parsers to generate a Document object
import 'package:html/dom.dart';

import 'models/Speaker.dart'; // Contains DOM related classes for extracting data from elements
class data{

  Future initiate() async {
    var client = Client();
    Response response = await client.get('https://2020.hackerkiste.de');
    // Use html parser
    var document = parse(response.body);

    getSpeakers(document);
    getBarcamps(document);
    getHackathons(document);
  }


  List<Speaker> getSpeakers(doc) {
    List<Element> domSpeakers = doc.querySelectorAll('#speaker .layout-three-images-text > .article-content > div');
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

  List<Barcamp> getBarcamps(doc) {
    List<Element> domBarcamps = doc.querySelectorAll('#zeitplan > .section-content > .sortable-article > article');
    List<Barcamp> barcampList = [];

    int barcampsStarted = null;
    int barcampsEnded = null;
    for (var i = 0; i < domBarcamps.length; i++) {
      if (barcampsStarted == null) {
        if (domBarcamps[i].innerHtml.contains("BISHER EINGEREICHTE BARCAMPS")) {
          barcampsStarted = i + 1;
        } else {
          if (barcampsEnded != null && !domBarcamps[i].innerHtml.contains("Beschreibung")) {
            barcampsEnded = i;
          }
        }
      }
    }

    for (var i = barcampsStarted; i <= barcampsEnded; i++) {
      var domBarcamp = domBarcamps[i];
      var format = domBarcamp.querySelector(".col-ten > h3");
      var organizer = domBarcamp.querySelector(".col-ten > h5").innerHtml.substring(2);
      var organizerName = organizer.split(", ")[0];
      var organizerCompany = organizer.split(", ")[2];
      var barcamp = new Barcamp();
      barcamp.format = format.innerHtml;
      barcamp.organizerCompany = organizerCompany;
      barcamp.organizerName = organizerName;
      barcampList.add(barcamp);
    }
    return barcampList;
  }

  List<Hackathon> getHackathons(doc) {
    List<Element> domHackathons = doc.querySelectorAll('#zeitplan > .section-content > .sortable-article > article');
    List<Hackathon> hackathonList = [];

    int hackathonsStarted = null;
    int hackathonsEnded = null;
    for (var i = 0; i < domHackathons.length; i++) {
      if (hackathonsStarted == null) {
        if (domHackathons[i].innerHtml.contains("BISHER EINGEREICHTE BARCAMPS")) {
          hackathonsStarted = i + 1;
        } else {
          if (hackathonsEnded != null && !domHackathons[i].innerHtml.contains("Beschreibung")) {
            hackathonsEnded = i;
          }
        }
      }
    }

    for (var i = hackathonsStarted; i <= hackathonsEnded; i++) {
      var domBarcamp = domHackathons[i];
      var format = domBarcamp.querySelector(".col-ten > h3");
      var organizer = domBarcamp.querySelector(".col-ten > h5").innerHtml.substring(2);
      var organizerName = organizer.split(", ")[0];
      var organizerCompany = organizer.split(", ")[2];
      var hackathon = new Hackathon();
      //TODO FILL
      hackathonList.add(hackathon);
    }
    return hackathonList;
  }

}