import 'package:flutter/material.dart';
import 'package:chirayu_music/data/history_manager.dart';
import 'package:chirayu_music/features/screens/player_screen.dart';
import 'package:chirayu_music/data/player_manager.dart';

class MusicScreen extends StatelessWidget {
  const MusicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final history = HistoryManager.history;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Recently Played"),
        backgroundColor: Colors.black,
      ),
      body: history.isEmpty
          ? const Center(
              child: Text(
                "No songs played yet",
                style: TextStyle(color: Colors.white),
              ),
            )
          : ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                final song = history[index];

                return ListTile(
                  leading: Image.network(song.thumbnail),
                  title: Text(
                    song.title,
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    song.channel,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PlayerScreen(song: song),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
