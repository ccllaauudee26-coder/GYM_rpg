import 'package:flutter/material.dart';

import '../services/exercise_favorites_service.dart';

class FavoriteButton extends StatefulWidget {
  final String exerciseName;

  const FavoriteButton({
    super.key,
    required this.exerciseName,
  });

  @override
  State<FavoriteButton> createState() =>
      _FavoriteButtonState();
}

class _FavoriteButtonState
    extends State<FavoriteButton> {
  bool favorite = false;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    await ExerciseFavoritesService.load();

    if (!mounted) {
      return;
    }

    setState(() {
      favorite =
          ExerciseFavoritesService.isFavorite(
        widget.exerciseName,
      );

      loading = false;
    });
  }

  Future<void> _toggle() async {
    if (loading) {
      return;
    }

    await ExerciseFavoritesService.toggle(
      widget.exerciseName,
    );

    if (!mounted) {
      return;
    }

    setState(() {
      favorite = !favorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _toggle,
      icon: Icon(
        favorite
            ? Icons.favorite
            : Icons.favorite_border,
        color: favorite
            ? Colors.redAccent
            : Colors.white70,
      ),
      tooltip: favorite
          ? "Remove from favorites"
          : "Add to favorites",
    );
  }
}