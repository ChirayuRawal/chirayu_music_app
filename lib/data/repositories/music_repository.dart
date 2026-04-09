import '../models/song_model.dart';
import '../services/youtube_service.dart';

class MusicRepository {
  final YoutubeService service = YoutubeService();

  Future<List<SongModel>> searchSongs(String query) async {
    final data = await service.fetchSongs(query);

    return data
        .map<SongModel>((e) => SongModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
