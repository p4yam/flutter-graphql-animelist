part of 'anime_cubit.dart';

@immutable
abstract class AnimeState {}

class AnimeInitial extends AnimeState {}

class AnimeLoading extends AnimeState {}

class AnimeContent extends AnimeState {
  AnimeContent(this.animeList);

  final List<Media> animeList;
}

class AnimeError extends AnimeState {
  AnimeError(this.errorMessage);

  final String errorMessage;
}
