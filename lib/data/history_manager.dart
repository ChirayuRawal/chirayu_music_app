import 'package:flutter/material.dart';
import 'package:chirayu_music/data/models/song_model.dart';

class HistoryManager {
  static List<SongModel> history = [];

  static void addSong(SongModel song) {
    // duplicate remove
    history.removeWhere((s) => s.videoId == song.videoId);

    // add on top
    history.insert(0, song);
    print("History Length: ${history.length}");

    // limit history
    if (history.length > 20) {
      history.removeLast();
    }
  }
}
