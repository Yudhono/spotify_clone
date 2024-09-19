import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/common/helpers/is_dark_mode.dart';
import 'package:spotify_clone/common/widgets/appbar/app_bar.dart';
import 'package:spotify_clone/core/configs/constants/app_url.dart';
import 'package:spotify_clone/core/configs/theme/app_colors.dart';
import 'package:spotify_clone/domain/entities/song/song.dart';
import 'package:spotify_clone/presentation/song_player/bloc/song_player_cubit.dart';
import 'package:spotify_clone/presentation/song_player/bloc/song_player_state.dart';

class SongPlayerPage extends StatelessWidget {
  final SongEntity songEntity;
  const SongPlayerPage({required this.songEntity, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: const Text(
          'Now Playing',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        action: IconButton(
          icon: const Icon(
            Icons.more_vert_rounded,
            size: 30,
            color: AppColors.primary,
          ),
          onPressed: () {},
        ),
      ),
      body: BlocProvider(
        create: (context) => SongPlayerCubit()
          ..loadSong(
              '${AppURLs.songFirestorage}${songEntity.title}-${songEntity.artist}.mp3?${AppURLs.mediaAlt}'),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              _songCover(context),
              const SizedBox(
                height: 20,
              ),
              _songDetail(context),
              const SizedBox(
                height: 20,
              ),
              _songPlayer(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _songCover(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
                '${AppURLs.coverFirestorage}${songEntity.title}_${songEntity.artist}.jpg?${AppURLs.mediaAlt}')),
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  Widget _songDetail(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              songEntity.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              songEntity.artist,
              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
            ),
          ],
        ),
        const Icon(
          Icons.favorite_border_rounded,
          color: AppColors.primary,
          size: 30,
        )
      ],
    );
  }

  Widget _songPlayer(BuildContext context) {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
      builder: (context, state) {
        if (state is SongPlayerInitial) {
          return const SizedBox();
        } else if (state is SongPlayerLoading) {
          return const CircularProgressIndicator();
        } else if (state is SongPlayerLoaded) {
          return Column(
            children: [
              Slider(
                  value: context
                      .read<SongPlayerCubit>()
                      .songPosition
                      .inSeconds
                      .toDouble(),
                  min: 0,
                  max: context
                      .read<SongPlayerCubit>()
                      .songDuration
                      .inSeconds
                      .toDouble(),
                  onChanged: (value) {}),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatDuration(
                        context.read<SongPlayerCubit>().songPosition),
                    style: const TextStyle(
                        color: AppColors.primary, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    formatDuration(
                        context.read<SongPlayerCubit>().songDuration),
                    style: const TextStyle(
                        color: AppColors.primary, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  context.read<SongPlayerCubit>().playOrPause();
                },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.primary),
                  child: Icon(
                      context.read<SongPlayerCubit>().audioPlayer.playing
                          ? Icons.pause
                          : Icons.play_arrow),
                ),
              )
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
