import 'package:event_view/infrastructure/favorites_store.dart';
import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  final String id;

  FavoriteButton(this.id) {}

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState(this.id);
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool saved = true;
  final String id;

  _FavoriteButtonState(this.id) {
    FavoritesStore.getInstance().isFavorite(id).then((value) => {
      setState(() {
        saved = value;
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        saved ? Icons.favorite : Icons.favorite_border,
        color: saved ? Colors.pink : Colors.yellow,
      ),
      onPressed: () {
        setState(() {
          if (saved) {
            FavoritesStore.getInstance().unmarkFavorite(id);
          } else {
            FavoritesStore.getInstance().markFavorite(id);
          }
          saved = !saved;
        });
      },
    );
  }
}
