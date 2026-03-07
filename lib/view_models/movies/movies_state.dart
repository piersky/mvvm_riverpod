import 'package:mvvm_statemanagements/models/movies_genre.dart';
import 'package:mvvm_statemanagements/models/movies_model.dart';

class MoviesState {
  final int currentPage;
  final List<MovieModel> moviesList;
  final List<MoviesGenre> moviesGenresList;
  final bool isLoading;
  final String fetchMoviesError;

  MoviesState({
    this.currentPage = 0,
    this.moviesList = const [],
    this.moviesGenresList = const [],
    this.isLoading = false,
    this.fetchMoviesError = "",
  });

  MoviesState copyWith({
    int? currentPage,
    List<MovieModel>? moviesList,
    List<MoviesGenre>? moviesGenresList,
    bool? isLoading,
    String? fetchMoviesError,
  }) {
    return MoviesState(
      currentPage: currentPage ?? this.currentPage,
      moviesList: moviesList ?? this.moviesList,
      moviesGenresList: moviesGenresList ?? this.moviesGenresList,
      isLoading: isLoading ?? this.isLoading,
      fetchMoviesError: fetchMoviesError ?? this.fetchMoviesError,
    );
  }
}
