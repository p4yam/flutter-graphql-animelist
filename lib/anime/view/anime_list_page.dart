import 'package:anilist_graphql/anime/manager/anime_cubit.dart';
import 'package:anilist_graphql/anime/view/anime_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimeListPage extends StatelessWidget {
  const AnimeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anime List'),
      ),
      body: BlocBuilder<AnimeCubit, AnimeState>(
        builder: (context, state) {
          if (state is AnimeContent) {
            return NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                    context.read<AnimeCubit>().fetchNextPage();
                  }
                  return false;
                },
                child: ListView.builder(
                  itemCount: state.animeList.length,
                  itemBuilder: (_, index) =>
                      AnimeItem(anime: state.animeList[index]),
                ));
          } else if (state is AnimeError) {
            return Center(
              child: Text(state.errorMessage),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
