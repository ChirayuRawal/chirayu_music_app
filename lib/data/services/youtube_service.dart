import 'dart:convert';
import 'package:chirayu_music/data/models/song_model.dart';
import 'package:http/http.dart' as http;

class YoutubeService {
  final String apiKey = 'AIzaSyAmd_MQovkf2-ijluFlCQvca5IU9J8VG-g';

  Future<List<SongModel>> fetchSongs(String query) async {
    final url = Uri.parse(
      'https://www.googleapis.com/youtube/v3/search'
      '?part=snippet'
      '&type=video'
      '&maxResults=10'
      '&videoCategoryId=10'
      '&q=${Uri.encodeComponent(query)}'
      '&key=$apiKey',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final items = data['items'] as List;

      return items.map((item) {
        return SongModel(
          videoId: item['id']['videoId'],
          title: item['snippet']['title'],
          thumbnail: item['snippet']['thumbnails']['high']['url'],
          channel: item['snippet']['channelTitle'],
        );
      }).toList();
    } else {
      throw Exception("Error fetching songs");
    }
  }
}
