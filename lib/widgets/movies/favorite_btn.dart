import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_statemanagements/models/movies_model.dart';
import 'package:mvvm_statemanagements/view_models/favorites/favorites_provider.dart';

import '../../constants/my_app_icons.dart';

class FavoriteBtnWidget extends ConsumerWidget {
  const FavoriteBtnWidget({super.key, required this.movieModel});
  final MovieModel movieModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesList =
        ref.watch(favoritesProvider.select((state) => state.favoritesList));
    final isFavorite = favoritesList.any((movie) => movie.id == movieModel.id);
    return IconButton(
      onPressed: () {
        if (isFavorite) {
          ref.read(favoritesProvider.notifier).removeFavorite(movieModel);
        } else {
          ref.read(favoritesProvider.notifier).addFavorite(movieModel);
        }
      },
      icon: Icon(
        isFavorite
            ? MyAppIcons.favoriteRounded
            : MyAppIcons.favoriteOutlineRounded,
        color: isFavorite ? Colors.red : null,
        size: 20,
      ),
    );
  }
}
