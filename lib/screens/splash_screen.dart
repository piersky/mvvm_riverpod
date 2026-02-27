import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_statemanagements/screens/movies_screen.dart';
import 'package:mvvm_statemanagements/service/init_getit.dart';
import 'package:mvvm_statemanagements/service/navigation_service.dart';
import 'package:mvvm_statemanagements/view_models/movies/movies_provider.dart';

import '../widgets/my_error_widget.dart';

final initializationProvider = FutureProvider.autoDispose<void>((ref) async {
  ref.keepAlive();
  await Future.microtask(() async {
    await ref.read(moviesProvider.notifier).fetchMovies();
  });
});

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final moviesProviderRef = ref.watch(moviesProvider);
    final initWatch = ref.watch(initializationProvider);
    return initWatch.when(data: (_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        getIt<NavigationService>().navigateReplace(const MoviesScreen());
      });
      return const SizedBox.shrink();
    }, error: (error, _) {
      return MyErrorWidget(
        errorText: error.toString(),
        retryFunction: () => ref.refresh(initializationProvider),
      );
    }, loading: () {
      return const CircularProgressIndicator.adaptive();
    });
  }
}
