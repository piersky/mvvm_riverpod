import 'package:flutter_riverpod/legacy.dart';
import 'package:mvvm_statemanagements/models/movies_model.dart';
import 'package:mvvm_statemanagements/repository/movies_repo.dart';
import 'package:mvvm_statemanagements/service/init_getit.dart';
import 'package:mvvm_statemanagements/view_models/movies/movies_state.dart';

final moviesProvider = StateNotifierProvider<MoviesProvider, MoviesState>(
  (ref) => MoviesProvider(),
);

class MoviesProvider extends StateNotifier<MoviesState> {
  MoviesProvider() : super(MoviesState());

  final MoviesRepository _moviesRepository = getIt<MoviesRepository>();

  Future<void> fetchMovies() async {
    try {
      state = state.copyWith(isLoading: true, fetchMoviesError: "");
      if (state.moviesGenresList.isEmpty) {
        final genres = await _moviesRepository.fetchGenres();
        state = state.copyWith(moviesGenresList: genres);
      }
      final List<MovieModel> movies =
          await _moviesRepository.fetchMovies(page: state.currentPage);
      state = state.copyWith(
          moviesList: [...state.moviesList, ...movies],
          currentPage: state.currentPage + 1,
          fetchMoviesError: '',
          isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        fetchMoviesError: e.toString(),
      );
    }
  }
}
