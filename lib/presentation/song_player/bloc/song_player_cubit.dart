import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify_clone/presentation/song_player/bloc/song_player_state.dart';

class SongPlayerCubit extends Cubit<SongPlayerState> {
  AudioPlayer audioPlayer = AudioPlayer();

  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;

  SongPlayerCubit() : super(SongPlayerLoading()) {
    audioPlayer.positionStream.listen((position) {
      songPosition = position;
      updateSongPlayer();
    });

    audioPlayer.durationStream.listen((duration) {
      songDuration = duration!;
    });
  }

  void updateSongPlayer() {
    emit(SongPlayerLoaded());
  }

  Future<void> loadSong(String url) async {
    try {
      print('Loading song from URL: $url');
      await audioPlayer.setUrl(url);
      emit(SongPlayerLoaded());
      print('Song loaded successfully');
    } catch (e) {
      emit(SongPlayerFailure());
      print('Failed to load song: $e');
    }
  }

  void playOrPause() {
    print('playOrPause called');
    if (audioPlayer.playing) {
      print('Pausing song');
      audioPlayer.pause();
    } else {
      print('Playing song');
      audioPlayer.play();
    }

    emit(SongPlayerLoaded());
  }

  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }
}
