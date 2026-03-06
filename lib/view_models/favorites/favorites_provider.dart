import 'dart:convert';

import 'package:mvvm_statemanagements/models/movies_model.dart';
import 'package:mvvm_statemanagements/view_models/favorites/favorites_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:state_notifier/state_notifier.dart';

class FavoritesProvider extends StateNotifier<FavoritesState> {
  FavoritesProvider() : super(FavoritesState());

  final favskey = "favskey";

  void addFavorite(MovieModel item) {
    if (!isFavorite(item)) {
      state = state.copyWith(favoritesList: [...state.favoritesList, item]);
    }
  }

  void removeFavorite(MovieModel item) {
    if (isFavorite(item)) {
      state = state.copyWith(
          favoritesList: state.favoritesList.where((i) => i != item).toList());
    }
  }

  bool isFavorite(MovieModel item) {
    return state.favoritesList.any((movie) => movie.id == item.id);
  }

  void clearAllFavs() {
    state.favoritesList.clear();
    state = state.copyWith(favoritesList: state.favoritesList);
  }

  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favsJsonList = state.favoritesList
        .map((movie) => json.encode(movie.toJson()))
        .toList();
    await prefs.setStringList(favskey, favsJsonList);
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favsJsonList = prefs.getStringList(favskey) ?? [];
    state.favoritesList.clear();
    state.favoritesList.addAll(favsJsonList
        .map((movieJson) => MovieModel.fromJson(json.decode(movieJson)))
        .toList());
    state = state.copyWith(favoritesList: state.favoritesList);
  }
}
