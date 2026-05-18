import 'package:flutter/material.dart';

import '../models/song.dart';
import '../widgets/song_card.dart';

class SongListScreen extends StatefulWidget {
  final ValueChanged<Song> onAddedToParent;

  const SongListScreen({super.key, required this.onAddedToParent});

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

  // 이 화면만의 독립적인 _playlist.
  // PlaylistScreen이 곡을 제거해도 여기까지 알림이 오지 않으므로
  // 카드는 한 번 "✓ 담김"이 되면 영원히 그 상태로 남는다 — 의도된 버그.
  final List<Song> _playlist = [];

  void _addToPlaylist(Song song) {
    final alreadyAdded = _playlist.any((item) => item.id == song.id);
    if (alreadyAdded) return;

    setState(() {
      _playlist.add(song);
    });
    widget.onAddedToParent(song);

    final colorScheme = Theme.of(context).colorScheme;
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(
            '${song.title}이 플레이리스트에 추가됐습니다',
            style: TextStyle(color: colorScheme.onInverseSurface),
          ),
          backgroundColor: colorScheme.inverseSurface,
          duration: const Duration(milliseconds: 1500),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('노래')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 18,
                  color: colorScheme.onPrimaryContainer,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '이 화면의 플레이리스트: ${_playlist.length}곡',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              itemCount: _songs.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
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
