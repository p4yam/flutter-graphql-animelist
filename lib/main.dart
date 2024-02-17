import 'package:anilist_graphql/anime/manager/anime_cubit.dart';
import 'package:anilist_graphql/anime/view/anime_list_page.dart';
import 'package:anilist_graphql/graphql_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anime List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => AnimeCubit(graphQLService: GraphQLService())
          ..fetchAnimeData(
            showLoading: true,
          ),
        child: const MaterialApp(
          home: AnimeListPage(),
        ),
      ),
    );
  }
}
