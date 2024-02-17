import 'package:anilist_graphql/anime/anime_model.dart';
import 'package:flutter/material.dart';

class AnimeItem extends StatelessWidget {
  final Media anime;

  const AnimeItem({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            anime.coverImageUrl ?? '',
            width: 128,
          ),
          const SizedBox(
            width: 6,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('title(en): ${anime.englishTitle ?? ''}'),
                Text('title(original): ${anime.nativeTitle}'),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  anime.description ?? '',
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
