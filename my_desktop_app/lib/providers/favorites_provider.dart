import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/wallpaper.dart';

class FavoritesProvider with ChangeNotifier {
  List<Wallpaper> _favorites = [];

  List<Wallpaper> get favorites => _favorites;

  FavoritesProvider() {
    loadFavorites();
  }

  bool isFavorite(String wallpaperId) {
    return _favorites.any((w) => w.id == wallpaperId);
  }

  void toggleFavorite(Wallpaper wallpaper) {
    if (isFavorite(wallpaper.id)) {
      _favorites.removeWhere((w) => w.id == wallpaper.id);
    } else {
      _favorites.add(wallpaper);
    }
    saveFavorites();
    notifyListeners();
  }

  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = _favorites
        .map((w) => jsonEncode(w.toJson()))
        .toList();
    await prefs.setStringList('favorites', favoritesJson);
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = prefs.getStringList('favorites') ?? [];
    _favorites = favoritesJson
        .map((json) => Wallpaper.fromJson(jsonDecode(json)))
        .toList();
    notifyListeners();
  }

  void clearFavorites() {
    _favorites.clear();
    saveFavorites();
    notifyListeners();
  }
}
