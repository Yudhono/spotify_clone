import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/domain/usecases/song/get_play_list.dart';
import 'package:spotify_clone/presentation/home/bloc/playlist_state.dart';
import 'package:spotify_clone/service_locator.dart';

class PlayListCubit extends Cubit<PlayListState> {
  PlayListCubit() : super(PlayListLoading());

  Future<void> getPlayList() async {
    var returnedSongs = await sl<GetPlayListUseCase>().call();
    returnedSongs.fold((l) {
      emit(PlayListLoadFailure(message: 'Failed to load new songs'));
    }, (data) {
      emit(PlayListLoaded(songs: data));
    });
  }
}
