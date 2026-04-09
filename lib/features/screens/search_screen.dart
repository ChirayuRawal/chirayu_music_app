import 'package:flutter/material.dart';
import 'package:chirayu_music/data/services/youtube_service.dart';
import 'package:chirayu_music/features/screens/player_screen.dart';
import 'package:chirayu_music/data/models/song_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController controller = TextEditingController();
  final YoutubeService service = YoutubeService();

  List<SongModel> songs = [];
  bool isLoading = false;

  // 🔍 Search Function
  void searchSongs(String query) async {
    if (query.trim().isEmpty) return;

    setState(() {
      isLoading = true;
    });

    try {
      final result = await service.fetchSongs(query);

      setState(() {
        songs = result;
      });
    } catch (e) {
      print(e);
    }

    setState(() {
      isLoading = false;
    });
  }

  // 🎨 Category Grid
  Widget buildCategoryGrid() {
    final colors = [
      Colors.purple,
      Colors.blue,
      Colors.red,
      Colors.orange,
      Colors.green,
      Colors.teal,
      Colors.pink,
      Colors.indigo,
    ];

    final titles = [
      "Pop",
      "Rock",
      "Hip Hop",
      "Jazz",
      "Classical",
      "EDM",
      "Romantic",
      "Workout",
    ];

    return GridView.builder(
      itemCount: titles.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: 1.5,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            searchSongs(titles[index]);
          },
          child: Container(
            decoration: BoxDecoration(
              color: colors[index],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Text(
                    titles[index],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Positioned(
                  right: -10,
                  bottom: -10,
                  child: Icon(
                    Icons.music_note,
                    size: 80,
                    color: Colors.white24,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // 🔍 Search Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: controller,
                  onSubmitted: (value) {
                    searchSongs(value);
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    icon: Icon(Icons.search, color: Colors.grey),
                    hintText: "Search songs, artists...",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                "Browse Categories",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              // 🎵 Content Area
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : songs.isNotEmpty
                    ? ListView.builder(
                        itemCount: songs.length,
                        itemBuilder: (context, index) {
                          final song = songs[index];

                          return ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                song.thumbnail,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              song.title,
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              song.channel,
                              style: const TextStyle(color: Colors.grey),
                            ),

                            // 🎧 PLAY SONG
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
                      )
                    : buildCategoryGrid(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
