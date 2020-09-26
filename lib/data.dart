import 'package:web_scraper/web_scraper.dart';
class data{
  void loadData() {
    final webScraper = WebScraper('https://2020.hackerkiste.de');
    if (webScraper.loadWebPage('/') != null) {
      final speakers = webScraper.getElement("#speaker .layout-three-images-text > .article-content > div", []);
      for (int i = 0; i < speakers.length; i++) {
        final speaker = speakers[i];
        print(speaker);
      }
      //final zeitplan = webScraper.getElement("#speaker .layout-three-images-text > .article-content > div", []);
    }
  }
}
