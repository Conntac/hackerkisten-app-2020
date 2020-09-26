import 'dart:convert'; // Contains the JSON encoder
import 'package:http/http.dart'; // Contains a client for making API calls
import 'package:html/parser.dart'; // Contains HTML parsers to generate a Document object
import 'package:html/dom.dart';

import 'models/Speaker.dart'; // Contains DOM related classes for extracting data from elements
import 'models/Hackathon.dart'; // Contains DOM related classes for extracting data from elements
import 'models/Event.dart'; // Contains DOM related classes for extracting data from elements
import 'models/Talk.dart'; // Contains DOM related classes for extracting data from elements
import 'models/Barcamp.dart'; // Contains DOM related classes for extracting data from elements

class WebsiteData {
  List<Barcamp> barcamps;
}

class data{

  Future initiate() async {
    var client = Client();
    Response response = await client.get('https://2020.hackerkiste.de');
    // zeitplan #speaker .layout-three-images-text > .article-content > div
    // Use html parser
    var document = parse(response.body);

    getSpeakers(document);
    //getBarcamps(document);
    //getHackathons(document);

    var websiteData = WebsiteData();
    websiteData.barcamps = getBarcamps(document);

    return websiteData;
  }


  List<Speaker> getSpeakers(doc) {
    List<Element> domSpeakers = doc.querySelectorAll('#speaker .layout-three-images-text > .article-content > div');
    List<Speaker> speakerList = [];

    for (var domSpeaker in domSpeakers) {
      var imgUrl = domSpeaker.querySelector("img").attributes['data-src'];
      var talkTitle = domSpeaker.querySelector("h3 font").innerHtml;
      var talkDescription = domSpeaker.children[2].innerHtml;
      var organizerElements = domSpeaker.children[3].querySelectorAll('font');
      var organizer = "";
      organizerElements.forEach((element) {
        organizer += element.text;
      });
      var name = organizer.split(',')[0];
      var company = organizer.replaceFirst(name + ',', '');
      var speaker = Speaker(name, company, imgUrl, talkTitle, talkDescription);
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
        }
      } else {
        if (barcampsEnded == null && !domBarcamps[i].innerHtml.contains("Beschreibung")) {
          barcampsEnded = i;
        }
      }
    }

    for (var i = barcampsStarted; i < barcampsEnded; i++) {
      var domBarcamp = domBarcamps[i];
      var format = domBarcamp.querySelector(".col-ten > h3");
      var organizer = domBarcamp.querySelector(".col-ten > h5").innerHtml.substring(2).replaceAll("&nbsp;", " ");
      var id = domBarcamp.querySelector(".col-ten > h5").innerHtml.substring(1, 2);
      var organizerName = organizer.split(", ")[0];

      var organizerCompany = organizer.split(", ")[2];
      var barcamp = new Barcamp();
      barcamp.format = format.innerHtml;
      barcamp.organizerCompany = organizerCompany;
      barcamp.organizerName = organizerName;
      barcamp.id = int.parse(id);
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
        } 
      } else {
        if (hackathonsEnded == null && !domHackathons[i].innerHtml.contains("Beschreibung")) {
          hackathonsEnded = i;
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