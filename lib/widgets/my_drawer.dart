import 'package:flutter/material.dart';
import 'package:moko/pages/folder_page/folder_page.dart';
import 'package:moko/pages/playlist_page/playlist_page.dart';
import 'package:moko/pages/song_page/song_page.dart';
import '../pages/settings_page/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          //HEADER OF DRAWER
          DrawerHeader(
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.music_note,
                  size: 40,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                const SizedBox(height: 10),
                Text(
                  'Moko',
                  style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 25),
            child: ListTile(
                title: const Text('P L A Y I N G  N O W'),
                leading: const Icon(Icons.play_arrow),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SongPage(),
                      ));
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 0),
            child: ListTile(
                title: const Text('P L A Y L I S T'),
                leading: const Icon(Icons.my_library_music),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PlaylistPage(),
                      ));
                }),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 20, top: 0),
          //   child: ListTile(
          //     title: const Text('F O L D E R S'),
          //     leading: const Icon(Icons.folder),
          //     onTap: () {
          //       Navigator.pop(context);
          //       Navigator.pushReplacement(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) => const FolderPage(),
          //           ));
          //     },
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 0),
            child: ListTile(
              title: const Text('S E T T I N G S'),
              leading: const Icon(Icons.settings),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsPage(),
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
