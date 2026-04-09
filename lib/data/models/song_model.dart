class SongModel {
  final String videoId;
  final String title;
  final String thumbnail;
  final String channel;

  SongModel({
    required this.videoId,
    required this.title,
    required this.thumbnail,
    required this.channel,
  });

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
      videoId: json['videoId'],
      title: json['title'],
      thumbnail: json['thumbnail'],
      channel: json['channel'] ?? '',
    );
  }
}
