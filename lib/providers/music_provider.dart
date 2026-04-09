import 'package:flutter/material.dart';
import '../data/models/song_model.dart';
import 'package:chirayu_music/data/repositories/music_repository.dart';

class MusicProvider with ChangeNotifier {
  final MusicRepository repo = MusicRepository();

  List<SongModel> songs = [];
  bool isLoading = false;

  Future<void> searchSongs(String query) async {
    isLoading = true;
    notifyListeners();

    songs = await repo.searchSongs(query);

    isLoading = false;
    notifyListeners();
  }
}
