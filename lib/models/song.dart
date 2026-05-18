import 'package:flutter/material.dart';

class Song {
  final int id;
  final String title;
  final String artist;
  final String genre;

  const Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.genre,
  });
}

class GenreStyle {
  final IconData icon;
  final Color color;

  const GenreStyle({required this.icon, required this.color});
}

const Map<String, GenreStyle> kGenreStyles = {
  '발라드': GenreStyle(icon: Icons.music_note, color: Color(0xFF5C6BC0)),
  '팝': GenreStyle(icon: Icons.star, color: Color(0xFFEC407A)),
  '댄스': GenreStyle(icon: Icons.bolt, color: Color(0xFFFF7043)),
  '힙합': GenreStyle(icon: Icons.mic, color: Color(0xFF26A69A)),
};

const GenreStyle kDefaultGenreStyle = GenreStyle(
  icon: Icons.headphones,
  color: Color(0xFF78909C),
);

GenreStyle styleForGenre(String genre) =>
    kGenreStyles[genre] ?? kDefaultGenreStyle;
