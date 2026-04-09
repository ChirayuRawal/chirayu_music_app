import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../data/models/song_model.dart';
import 'package:chirayu_music/data/history_manager.dart';
import 'package:chirayu_music/data/player_manager.dart';

class PlayerScreen extends StatefulWidget {
  final SongModel song;

  const PlayerScreen({super.key, required this.song});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late YoutubePlayerController controller;
  bool isPlaying = true;

  @override
  void initState() {
    super.initState();

    PlayerManager.currentSong = widget.song;
    PlayerManager.isPlaying = true;

    // 🔥 ADD TO HISTORY
    HistoryManager.addSong(widget.song);

    controller = YoutubePlayerController(
      initialVideoId: widget.song.videoId,
      flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
    );

    controller.addListener(() {
      setState(() {
        isPlaying = controller.value.isPlaying;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void togglePlay() {
    if (isPlaying) {
      controller.pause();
    } else {
      controller.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Now Playing"),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          YoutubePlayer(
            controller: controller,
            showVideoProgressIndicator: true,
          ),

          const SizedBox(height: 20),

          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              widget.song.thumbnail,
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              widget.song.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 10),

          Text(widget.song.channel, style: const TextStyle(color: Colors.grey)),

          const SizedBox(height: 30),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  controller.seekTo(
                    controller.value.position - const Duration(seconds: 10),
                  );
                },
                icon: const Icon(
                  Icons.replay_10,
                  color: Colors.white,
                  size: 30,
                ),
              ),

              const SizedBox(width: 20),

              GestureDetector(
                onTap: togglePlay,
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.black,
                    size: 35,
                  ),
                ),
              ),

              const SizedBox(width: 20),

              IconButton(
                onPressed: () {
                  controller.seekTo(
                    controller.value.position + const Duration(seconds: 10),
                  );
                },
                icon: const Icon(
                  Icons.forward_10,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
