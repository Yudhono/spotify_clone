import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/common/helpers/is_dark_mode.dart';
import 'package:spotify_clone/core/configs/theme/app_colors.dart';
import 'package:spotify_clone/domain/entities/song/song.dart';
import 'package:spotify_clone/presentation/home/bloc/playlist_cubit.dart';
import 'package:spotify_clone/presentation/home/bloc/playlist_state.dart';
import 'package:spotify_clone/presentation/song_player/pages/song_player.dart';

class PlayList extends StatelessWidget {
  const PlayList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PlayListCubit()..getPlayList(),
      child:
          BlocBuilder<PlayListCubit, PlayListState>(builder: (context, state) {
        if (state is PlayListLoading) {
          return Center(
              child: Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator()));
        } else if (state is PlayListLoaded) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Play List',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'See More',
                    style: TextStyle(
                        fontSize: 16,
                        color: context.isDarkMode
                            ? const Color(0xffc6c6c6)
                            : Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              _songs(state.songs),
              const SizedBox(
                height: 50,
              ),
            ],
          );
        } else if (state is PlayListLoadFailure) {
          return Center(child: Text(state.message));
        } else {
          return const SizedBox();
        }
      }),
    );
  }

  Widget _songs(List<SongEntity> songs) {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigate to song player page
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => SongPlayerPage(
                            songEntity: songs[index],
                          )));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: context.isDarkMode
                            ? AppColors.darkGrey
                            : const Color(0xffe6e6e6),
                      ),
                      child: Icon(
                        Icons.play_arrow_rounded,
                        color: context.isDarkMode
                            ? const Color(0xff959595)
                            : const Color(0xff555555),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          songs[index].title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          songs[index].artist,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 15),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      songs[index].duration,
                      style: TextStyle(
                          color: context.isDarkMode
                              ? const Color(0xffc6c6c6)
                              : Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Icon(
                      Icons.favorite_border,
                      color: AppColors.primary,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Icon(
                      Icons.more_vert,
                      color: AppColors.primary,
                    ),
                  ],
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
              height: 20,
            ),
        itemCount: songs.length);
  }
}
