import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/song.dart';
import '../providers/playlist_provider.dart';
import '../widgets/song_card.dart';

class SongListScreen extends ConsumerWidget {
  const SongListScreen({super.key});

  static const List<Song> _songs = [
    Song(id: 1, title: '소문의 낙원', artist: 'AKMU', genre: '발라드'),
    Song(id: 2, title: 'RED', artist: 'CORTIS', genre: '팝'),
    Song(id: 3, title: "It's Me", artist: '아일릿', genre: '팝'),
    Song(id: 4, title: '기쁨, 슬픔, 아름다운 마음', artist: 'AKMU', genre: '발라드'),
    Song(id: 5, title: 'RUDE!', artist: 'Hearts2Hearts', genre: '댄스'),
    Song(id: 6, title: '캐치 캐치', artist: '최예나', genre: '댄스'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final playlist = ref.watch(playlistProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '노래',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 18,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '이 화면의 플레이리스트: ${playlist.length}곡',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              itemCount: _songs.length,
              itemBuilder: (context, index) {
                final song = _songs[index];
                final isAdded =
                    playlist.any((item) => item.id == song.id);
                return SongCard(
                  song: song,
                  isAdded: isAdded,
                  onAdd: () =>
                      ref.read(playlistProvider.notifier).addSong(song),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
