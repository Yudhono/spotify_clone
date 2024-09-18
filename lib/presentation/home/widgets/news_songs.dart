import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/common/helpers/is_dark_mode.dart';
import 'package:spotify_clone/core/configs/constants/app_url.dart';
import 'package:spotify_clone/core/configs/theme/app_colors.dart';
import 'package:spotify_clone/domain/entities/song/song.dart';
import 'package:spotify_clone/presentation/home/bloc/news_songs_cubit.dart';
import 'package:spotify_clone/presentation/home/bloc/news_songs_state.dart';

class NewsSongs extends StatelessWidget {
  const NewsSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewsSongsCubit()..getNewsSongs(),
      child: SizedBox(
        height: 200,
        child: BlocBuilder<NewsSongsCubit, NewsSongsState>(
            builder: (context, state) {
          if (state is NewsSongsLoading) {
            return Center(
                child: Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator()));
          } else if (state is NewsSongsLoaded) {
            return _songs(state.songs);
          } else if (state is NewsSongsLoadFailure) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox();
          }
        }),
      ),
    );
  }

  Widget _songs(List<SongEntity> songs) {
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 160,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          '${AppURLs.coverFirestorage}${songs[index].title}_${songs[index].artist}.jpg?${AppURLs.mediaAlt}'),
                    )),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 40,
                    width: 40,
                    transform: Matrix4.translationValues(10, 10, 0),
                    decoration: BoxDecoration(
                        color: context.isDarkMode
                            ? Colors.white
                            : AppColors.darkGrey,
                        shape: BoxShape.circle),
                    child: Icon(Icons.play_arrow_rounded,
                        color:
                            context.isDarkMode ? Colors.black : Colors.white),
                  ),
                ),
              )),
              const SizedBox(
                height: 10,
              ),
              Text(
                songs[index].title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                songs[index].artist,
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
              ),
            ]),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 14),
        itemCount: songs.length);
  }
}
