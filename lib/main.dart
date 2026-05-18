import 'package:flutter/material.dart';

import 'models/song.dart';
import 'screens/playlist_screen.dart';
import 'screens/song_list_screen.dart';

void main() {
  runApp(const MusicApp());
}

class MusicApp extends StatelessWidget {
  const MusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF6750A4),
    );

    return MaterialApp(
      title: '플레이리스트',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: colorScheme.surface,
        appBarTheme: AppBarTheme(
          centerTitle: false,
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: colorScheme.surface,
          surfaceTintColor: Colors.transparent,
          titleTextStyle: TextStyle(
            color: colorScheme.onSurface,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const RootTabs(),
    );
  }
}

class RootTabs extends StatefulWidget {
  const RootTabs({super.key});

  @override
  State<RootTabs> createState() => _RootTabsState();
}

class _RootTabsState extends State<RootTabs> {
  int _currentIndex = 0;

  // RootTabs도 자체 _playlist를 들고 있다.
  // - SongListScreen이 추가 시 콜백으로 알려준 곡이 여기에 쌓이고,
  // - PlaylistScreen이 prop으로 이 리스트를 받아 표시한다.
  // - PlaylistScreen의 삭제 콜백도 여기서 처리해 이 리스트에서 제거한다.
  // 단 SongListScreen._playlist는 자기만의 사본을 유지해 외부 제거를 알지 못한다 — 의도된 버그.
  final List<Song> _playlist = [];

  void _addSong(Song song) {
    final alreadyAdded = _playlist.any((item) => item.id == song.id);
    if (alreadyAdded) return;

    setState(() {
      _playlist.add(song);
    });
  }

  void _removeSong(Song song) {
    setState(() {
      _playlist.removeWhere((item) => item.id == song.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final screens = <Widget>[
      SongListScreen(onAddedToParent: _addSong),
      PlaylistScreen(playlist: _playlist, onRemove: _removeSong),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        indicatorColor: colorScheme.primaryContainer,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
        },
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.music_note_outlined),
            selectedIcon: Icon(Icons.music_note),
            label: '노래',
          ),
          NavigationDestination(
            icon: _PlaylistTabIcon(
              count: _playlist.length,
              icon: Icons.queue_music_outlined,
              theme: theme,
            ),
            selectedIcon: _PlaylistTabIcon(
              count: _playlist.length,
              icon: Icons.queue_music,
              theme: theme,
            ),
            label: '플레이리스트',
          ),
        ],
      ),
    );
  }
}

class _PlaylistTabIcon extends StatelessWidget {
  final int count;
  final IconData icon;
  final ThemeData theme;

  const _PlaylistTabIcon({
    required this.count,
    required this.icon,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(icon),
        if (count > 0)
          Positioned(
            right: -8,
            top: -6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
              child: Text(
                '$count',
                style: TextStyle(
                  color: theme.colorScheme.onPrimary,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
