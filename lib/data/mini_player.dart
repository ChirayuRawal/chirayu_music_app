import 'package:flutter/material.dart';
import 'package:chirayu_music/data/player_manager.dart';
import 'package:chirayu_music/features/screens/player_screen.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final song = PlayerManager.currentSong;

    if (song == null) return const SizedBox();

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => PlayerScreen(song: song)),
        );
      },
      child: Container(
        height: 65,
        color: Colors.grey[900],
        child: Row(
          children: [
            Image.network(song.thumbnail, width: 60, fit: BoxFit.cover),
            const SizedBox(width: 10),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    song.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                    song.channel,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),

            const Icon(Icons.play_arrow, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
