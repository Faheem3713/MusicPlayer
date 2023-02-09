import 'package:flutter/material.dart';
import 'package:musicplayer/screens/most_played.dart';
import 'package:musicplayer/screens/recently_played.dart';

import '../../screens/about.dart';
import '../../screens/allsongs.dart';
import '../../screens/favorites.dart';
import '../../screens/playlistsongs/playlists.dart';
import '../../screens/settings.dart';

class TextHardCode {
  // ignore: prefer_final_fields
  static List<Library> library = [
    Library(
        icon: const Icon(Icons.favorite),
        text: 'Favorites',
        pages: const Favorites()),
    Library(
        icon: const Icon(Icons.queue_music_outlined),
        text: 'Playlists',
        pages: const PlayLists()),
    Library(
        icon: const Icon(Icons.music_note_outlined),
        text: 'All Songs',
        pages: AllSongs()),
    // Library(
    //     icon: const Icon(Icons.album), text: 'Albums', pages: const Albums()),
    Library(
        icon: const Icon(Icons.graphic_eq_outlined),
        text: 'Recently played',
        pages: const RecentlyPlayed()),
    Library(
        icon: const Icon(Icons.more_time),
        text: 'Most played',
        // ignore: prefer_const_constructors
        pages: MostPlayed()),
    Library(
        icon: const Icon(Icons.settings), text: 'Settings', pages: Settings()),
    Library(
      icon: const Icon(Icons.info_outlined),
      text: 'About',
      pages: const About(),
    )
  ];
}

class Library {
  final Icon icon;
  final String text;
  final Widget pages;

  Library({
    required this.icon,
    required this.text,
    required this.pages,
  });
}
