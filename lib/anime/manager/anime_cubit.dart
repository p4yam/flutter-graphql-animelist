import 'package:anilist_graphql/anime/anime_model.dart';
import 'package:anilist_graphql/graphql_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'anime_state.dart';

class AnimeCubit extends Cubit<AnimeState> {
  AnimeCubit({required this.graphQLService}) : super(AnimeInitial());

  final GraphQLService graphQLService; // Your GraphQL service instance

  // GraphQL query string
  static const String _animeQuery = r'''
    query ($page: Int, $perPage: Int) {
      Page (page: $page, perPage: $perPage) {
        pageInfo {
          total
          currentPage
          lastPage
          hasNextPage
          perPage
        }
        media {
          id
          coverImage{
            extraLarge
          }
          title {
            english
            native
          }
          description
        }
      }
    }
  ''';
  static const int _perPage = 20;
  final List<Media> _animeList = [];
  var _currentPage = 1;
  var _totalPages = 1;

  // Method to fetch anime data using GraphQL query
  Future<void> fetchAnimeData({bool showLoading = false}) async {
    try {
      if (showLoading) {
        emit(AnimeLoading()); // Loading state
      }

      final result = await graphQLService.query(
        _animeQuery, // Use the static query string
        variables: {'page': _currentPage, 'perPage': _perPage},
      );

      if (result.hasException) {
        emit(AnimeError(result.exception?.graphqlErrors.first.message ??
            'Error fetching data')); // Error state
      }

      final AnimeModel animeData =
          AnimeModel.fromJson(result.data?['Page'] ?? {});
      _totalPages = animeData.pageInfo.total;
      _animeList.addAll(animeData.media);
      emit(AnimeContent(_animeList)); // Success state with anime list
    } catch (e) {
      emit(AnimeError(e.toString())); // Error state
    }
  }

  Future<void> fetchNextPage() async {
    if (_currentPage < _totalPages) {
      _currentPage++;
      await fetchAnimeData();
    }
  }
}
