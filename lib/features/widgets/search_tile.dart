import 'package:chirayu_music/features/screens/player_screen.dart';
import 'package:flutter/material.dart';
import '../../data/models/song_model.dart';
import 'package:chirayu_music/features/screens/player_screen.dart';

class SearchTile extends StatelessWidget {
  final SongModel song;

  const SearchTile({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(song.thumbnail),
      title: Text(song.title, style: const TextStyle(color: Colors.white)),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => PlayerScreen(song: song)),
        );
      },
    );
  }
}
