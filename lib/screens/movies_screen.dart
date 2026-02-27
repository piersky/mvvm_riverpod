import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_statemanagements/enums/theme_enums.dart';
import 'package:mvvm_statemanagements/view_models/movies/movies_provider.dart';
import 'package:mvvm_statemanagements/view_models/theme_provider.dart';

import '../constants/my_app_icons.dart';
import '../service/init_getit.dart';
import '../service/navigation_service.dart';
import '../widgets/movies/movies_widget.dart';
import 'favorites_screen.dart';

class MoviesScreen extends ConsumerWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Popular Movies"),
        actions: [
          IconButton(
            onPressed: () {
              // getIt<NavigationService>().showSnackbar();
              // getIt<NavigationService>().showDialog(MoviesWidget());
              getIt<NavigationService>().navigate(const FavoritesScreen());
            },
            icon: const Icon(
              MyAppIcons.favoriteRounded,
              color: Colors.red,
            ),
          ),
          IconButton(
            onPressed: () async {
              await ref.read(themeProvider.notifier).toggleTheme();
            },
            icon: Icon(
              themeState == ThemeEnums.light
                  ? MyAppIcons.lightMode
                  : MyAppIcons.darkMode,
            ),
          ),
        ],
      ),
      body: Consumer(builder: (context, WidgetRef ref, child) {
        final moviesState = ref.watch(moviesProvider);

        return ListView.builder(
          itemCount: moviesState.moviesList.length,
          itemBuilder: (context, index) {
            return const MoviesWidget();
          },
        );
      }),
    );
  }
}
