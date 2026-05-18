import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/song.dart';

class PlaylistNotifier extends Notifier<List<Song>> {
  @override
  List<Song> build() => const [];

  void addSong(Song song) {
    final alreadyAdded = state.any((item) => item.id == song.id);
    if (alreadyAdded) return;

    state = [...state, song];
  }

  void removeSong(Song song) {
    state = state.where((item) => item.id != song.id).toList();
  }
}

final playlistProvider = NotifierProvider<PlaylistNotifier, List<Song>>(
  () => PlaylistNotifier(),
);
