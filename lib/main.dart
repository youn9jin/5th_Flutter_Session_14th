import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/playlist_provider.dart';
import 'screens/playlist_screen.dart';
import 'screens/song_list_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MusicApp(),
    ),
  );
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

class RootTabs extends ConsumerStatefulWidget {
  const RootTabs({super.key});

  @override
  ConsumerState<RootTabs> createState() => _RootTabsState();
}

class _RootTabsState extends ConsumerState<RootTabs> {
  int _currentIndex = 0;

  static const List<Widget> _screens = [
    SongListScreen(),
    PlaylistScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final playlist = ref.watch(playlistProvider);

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
              count: playlist.length,
              icon: Icons.queue_music_outlined,
              theme: theme,
            ),
            selectedIcon: _PlaylistTabIcon(
              count: playlist.length,
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
