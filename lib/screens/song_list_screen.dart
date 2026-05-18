import 'package:flutter/material.dart';

import '../models/song.dart';
import '../widgets/song_card.dart';

class SongListScreen extends StatefulWidget {
  const SongListScreen({super.key});

  @override
  State<SongListScreen> createState() => _SongListScreenState();
}

class _SongListScreenState extends State<SongListScreen> {
  static const List<Song> _songs = [
    Song(id: 1, title: '소문의 낙원', artist: 'AKMU', genre: '발라드'),
    Song(id: 2, title: 'RED', artist: 'CORTIS', genre: '팝'),
    Song(id: 3, title: "It's Me", artist: '아일릿', genre: '팝'),
    Song(id: 4, title: '기쁨, 슬픔, 아름다운 마음', artist: 'AKMU', genre: '발라드'),
    Song(id: 5, title: 'RUDE!', artist: 'Hearts2Hearts', genre: '댄스'),
    Song(id: 6, title: '캐치 캐치', artist: '최예나', genre: '댄스'),
  ];

  // 이 화면만의 독립적인 플레이리스트 상태.
  // PlaylistScreen에는 절대 공유되지 않는다 — 의도된 버그.
  final List<Song> _playlist = [];

  void _addToPlaylist(Song song) {
    final alreadyAdded = _playlist.any((item) => item.id == song.id);
    if (alreadyAdded) return;

    setState(() {
      _playlist.add(song);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
                    '이 화면의 플레이리스트: ${_playlist.length}곡',
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
                    _playlist.any((item) => item.id == song.id);
                return SongCard(
                  song: song,
                  isAdded: isAdded,
                  onAdd: () => _addToPlaylist(song),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
