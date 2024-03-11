import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:moko/pages/song_page/song_page.dart';
import 'package:moko/pages/song_page/song_page_logic.dart';
import 'package:moko/services/service_locator.dart';
import 'package:moko/widgets/my_drawer.dart';

class PlaylistPage extends StatefulWidget {
  const PlaylistPage({super.key});
  @override
  State<PlaylistPage> createState() => _HomePageState();
}

class _HomePageState extends State<PlaylistPage> {
  @override
  void initState() {
    getIt<SongPageLogic>().init();
    super.initState();
  }

  void playSong(int index) {
    final _audioHandler = getIt<AudioHandler>();
    _audioHandler.skipToQueueItem(index);
    _audioHandler.play();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SongPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final songPageLogic = getIt<SongPageLogic>();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('P L A Y L I S T'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  songPageLogic.loadMoreSongs();
                });
              },
              icon: const Icon(Icons.add))
        ],
      ),
      drawer: const MyDrawer(),
      body: ValueListenableBuilder<List<String>>(
        valueListenable: songPageLogic.playlistNotifier,
        builder: (context, playlistTitles, _) {
          return ListView.builder(
            itemCount: playlistTitles.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(playlistTitles[index]),
                subtitle: Text('Artirst Name'),
                //TODO: FIGURE A WAY TO ADD THEM BACK
                //   title: Text(song.songName),
                // subtitle: Text(song.artistName),
                // leading: Image.asset(song.albumArtImagePath),
                onTap: () => playSong(index),
              );
            },
          );
        },
      ),
    );
  }
}
