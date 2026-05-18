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
    return MaterialApp(
      title: '플레이리스트',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6750A4)),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 0,
          scrolledUnderElevation: 0,
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

  // 의도적으로 두 화면을 독립된 인스턴스로 둔다.
  // 각 화면이 자체적으로 _playlist를 관리하므로 서로 동기화되지 않는다.
  static const List<Widget> _screens = [
    SongListScreen(),
    PlaylistScreen(),
  ];

  // 뱃지에 표시할 카운트도 여기서 따로 들고 있다.
  // 두 화면의 _playlist에 접근할 수 없으므로 RootTabs는 자기만의 0개짜리
  // 카운트만 알 뿐이다. 결과적으로 뱃지는 영원히 0(=비표시) 상태가 된다 — 의도된 버그.
  final List<Song> _playlist = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
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
