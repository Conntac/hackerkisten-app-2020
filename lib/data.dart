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
  List<Hackathon> hackathons;
  List<Speaker> speakers;
}

class data{

  Future initiate() async {
    var client = Client();
    Response response = await client.get('https://2020.hackerkiste.de');
    // zeitplan #speaker .layout-three-images-text > .article-content > div
    // Use html parser
    var document = parse(response.body);

    var websiteData = WebsiteData();
    websiteData.barcamps = getBarcamps(document);
    websiteData.speakers = getSpeakers(document);
    websiteData.hackathons = getHackathons(document);

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
      String nbsp = DocumentFragment.html("&nbsp;").text;
      var company = organizer.replaceAll(nbsp, " ");
      company = company.replaceFirst(name + ", ", "");
      var speaker = Speaker(name, company, imgUrl, talkTitle, talkDescription);
      speakerList.add(speaker);
    }
    return speakerList;
  }

  List<Barcamp> getBarcamps(doc) {
    List<Element> domBarcamps = doc.querySelectorAll('#zeitplan > .section-content > .sortable-article > article');
    List<Barcamp> barcampList = [];
    String nbsp = DocumentFragment.html("&nbsp;").text;

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
      var title = domBarcamp.querySelector(".col-ten > h3").text;
      var organizer = domBarcamp.querySelector(".col-ten > h5").innerHtml.substring(2).replaceAll("&nbsp;", " ");
      var id = int.parse(domBarcamp.querySelector(".col-ten > h5").innerHtml.substring(1, 2));
      var organizerName = organizer.split(", ")[0];
      organizerName = organizerName.replaceFirst(" ", "");
      var organizerCompany = organizer.split(", ")[2];
      organizerCompany = organizerCompany.replaceAll(nbsp, "");
      organizerCompany = organizerCompany.replaceAll("</span>", "");

      var infos = domBarcamp.querySelector("div.open-sans").text;
      RegExp exp = new RegExp(r"Beschreibung:(.+)Format:(.+)");
      var description = exp.allMatches(infos).map((e) => e.group(1)).toList()[0];
      var format = exp.allMatches(infos).map((e) => e.group(2)).toList()[0];
      var barcamp = new Barcamp(id, title, description, format, organizerName, organizerCompany);
      barcampList.add(barcamp);
    }
    return barcampList;
  }

  List<Hackathon> getHackathons(doc) {
    List<Element> domHackathons = doc.querySelectorAll('#zeitplan > .section-content > .sortable-article > article');
    List<Hackathon> hackathonList = [];
    RegExp exp1 = new RegExp(r"Beschreibung:(.+?)(Szenario\/Aufgabe:|Szenario:)(.+?)(Betreuung:(.+?))?(Gestellt werden:(.+?))?Voraussetzung:(.+?)Schwierigkeitsgrad:(.+)");

    int hackathonsStarted = null;
    int hackathonsEnded = null;
    for (var i = 0; i < domHackathons.length; i++) {
      if (hackathonsStarted == null) {
        if (domHackathons[i].innerHtml.contains("BISHER EINGEREICHTE HACKATHONS")) {
          hackathonsStarted = i + 1;
        } 
      } else {
        if (hackathonsEnded == null && !domHackathons[i].innerHtml.contains("Beschreibung")) {
          hackathonsEnded = i;
        }
      }
    }
    for (var i = hackathonsStarted; i < hackathonsEnded; i++) {
      var domHackathon = domHackathons[i];
      var title = domHackathon.querySelector(".col-ten > h3");
      RegExp exp2 = new RegExp(r"#(\d+)");
      var headline = domHackathon.querySelector(".col-ten > h5").text;
      var id = int.parse(exp2.firstMatch(headline).group(1));
      var organizer = headline.substring(2);
      String nbsp = DocumentFragment.html("&nbsp;").text;
      organizer = organizer.replaceAll(nbsp, " ");
      var organizerValues = organizer.split(", ");
      var organizerName = organizerValues[0];
      var organizerRole = "";
      var organizerCompany = "";
      if (organizerValues.length == 3) {
        organizerRole = organizerValues[1];
        organizerCompany = organizerValues[2];
      } else {
        organizerCompany = organizerValues[1];
      }

      var infos = domHackathon.querySelector("div.open-sans").text;
      var description = exp1.allMatches(infos).map((e) => e.group(1)).toList()[0];
      var scenario = exp1.allMatches(infos).map((e) => e.group(3)).toList()[0];
      var delivered = exp1.allMatches(infos).map((e) => e.group(7)).toList()[0];
      var supervisor = exp1.allMatches(infos).map((e) => e.group(5)).toList()[0];
      var requirements = exp1.allMatches(infos).map((e) => e.group(8)).toList()[0];
      var difficulty = exp1.allMatches(infos).map((e) => e.group(9)).toList()[0];
      var hackathon = new Hackathon(id, scenario, supervisor, requirements, difficulty, delivered, organizerName, organizerCompany, organizerRole);
      hackathonList.add(hackathon);
    }
    return hackathonList;
  }

}