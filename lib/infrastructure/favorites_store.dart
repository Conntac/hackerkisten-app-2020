import 'package:shared_preferences/shared_preferences.dart';

class FavoritesStore {
  static const String favList = "favorites_list";
  static FavoritesStore _instance = null;

  _FavoritesStore() {}

  static FavoritesStore getInstance() {
    if (_instance == null) {
      _instance = FavoritesStore();
    }
    return _instance;
  }

  markFavorite(String id) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> favs = prefs.getStringList(favList) ?? new List<String>();
    favs.add(id);
    prefs.setStringList(favList, favs);
  }

  unmarkFavorite(String id) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> favs = prefs.getStringList(favList);
    favs.remove(id);
    prefs.setStringList(favList, favs);
  }

  Future<bool> isFavorite(String id) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> favs = prefs.getStringList(favList) ?? new List<String>();
    return favs.contains(id);
  }
}