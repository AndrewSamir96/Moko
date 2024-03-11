import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:moko/pages/playlist_page/playlist_page.dart';
import 'package:moko/pages/song_page/play_button_notifier.dart';
import 'package:moko/pages/song_page/progress_notifier.dart';
import 'package:moko/pages/song_page/repeat_button_notifier.dart';
import 'package:moko/pages/song_page/song_page_logic.dart';
import 'package:moko/services/service_locator.dart';
import 'package:moko/widgets/neu_box.dart';

class SongPage extends StatefulWidget {
  const SongPage({super.key});

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  // late AudioPlayer player;
  @override
  void initState() {
    // getIt<SongPageLogic>().init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final songPageLogic = getIt<SongPageLogic>();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('P L A Y I N G   N O W'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                songPageLogic.stop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlaylistPage(),
                    ));
              },
              icon: const Icon(Icons.close))
        ],
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 25, right: 25, bottom: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 25),
              SongInfo(),
              SizedBox(height: 15),
              MiscButtons(),
              AudioProgressBar(),
              SizedBox(height: 15),
              AudioControlButtons(),
              SizedBox(height: 10),
              // VolumeControlSlider(),
            ],
          ),
        ),
      ),
    );
  }
}

class SongInfo extends StatelessWidget {
  const SongInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final songPageLogic = getIt<SongPageLogic>();
    return NeuBox(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            //TODO: DO THE SAME AS SONG TITLE FOR THE IMAGE
            child: Image.asset('assets/images/beatles.jpg'),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ValueListenableBuilder<String>(
                      valueListenable: songPageLogic.currentSongTitleNotifier,
                      builder: (_, title, __) {
                        return Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        );
                      },
                    ),
                    //TODO: DO THE SAME AS SONG TITLE FOR THE SONG ARTIST
                    const Text('Adele'),
                  ],
                ),
                //FAVORITE BUTTON
                // const Icon(
                //   Icons.favorite,
                //   color: Colors.red,
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MiscButtons extends StatelessWidget {
  const MiscButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ShuffleButton(),
          RepeatButton(),
        ],
      ),
    );
  }
}

class RepeatButton extends StatelessWidget {
  const RepeatButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final songPageLogic = getIt<SongPageLogic>();
    return ValueListenableBuilder<RepeatState>(
      valueListenable: songPageLogic.repeatButtonNotifier,
      builder: (context, value, child) {
        Icon icon;
        switch (value) {
          case RepeatState.off:
            icon = const Icon(Icons.repeat, color: Colors.grey);
            break;
          case RepeatState.repeatSong:
            icon = const Icon(Icons.repeat_one);
            break;
          case RepeatState.repeatPlaylist:
            icon = const Icon(Icons.repeat);
            break;
        }
        return IconButton(
          icon: icon,
          onPressed: songPageLogic.repeat,
        );
      },
    );
  }
}

class ShuffleButton extends StatelessWidget {
  const ShuffleButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final songPageLogic = getIt<SongPageLogic>();
    return ValueListenableBuilder<bool>(
      valueListenable: songPageLogic.isShuffleModeEnabledNotifier,
      builder: (context, isEnabled, child) {
        return IconButton(
          icon: (isEnabled)
              ? const Icon(Icons.shuffle)
              : const Icon(Icons.shuffle, color: Colors.grey),
          onPressed: songPageLogic.shuffle,
        );
      },
    );
  }
}

class AudioProgressBar extends StatelessWidget {
  const AudioProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    final songPageLogic = getIt<SongPageLogic>();
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: songPageLogic.progressNotifier,
      builder: (_, value, __) {
        return ProgressBar(
          progress: value.current,
          //TODO: remove buffer if you don't like it
          buffered: value.buffered,
          total: value.total,
          onSeek: songPageLogic.seek,
          timeLabelLocation: TimeLabelLocation.above,
          progressBarColor: Colors.green,
          thumbColor: Colors.green,
          baseBarColor: Theme.of(context).colorScheme.secondary,
        );
      },
    );
  }
}

class AudioControlButtons extends StatelessWidget {
  const AudioControlButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        PreviousSongButton(),
        SizedBox(width: 20),
        PlayPauseButton(),
        SizedBox(width: 20),
        NextSongButton(),
      ],
    );
  }
}

class PreviousSongButton extends StatelessWidget {
  const PreviousSongButton({super.key});

  @override
  Widget build(BuildContext context) {
    final songPageLogic = getIt<SongPageLogic>();
    return Expanded(
      child: ValueListenableBuilder<bool>(
        valueListenable: songPageLogic.isFirstSongNotifier,
        builder: (_, isFirst, __) {
          return GestureDetector(
            onTap: (isFirst) ? null : songPageLogic.previous,
            child: const NeuBox(
              child: Icon(Icons.skip_previous),
            ),
          );
        },
      ),
    );
  }
}

class PlayPauseButton extends StatelessWidget {
  const PlayPauseButton({super.key});

  @override
  Widget build(BuildContext context) {
    final songPageLogic = getIt<SongPageLogic>();
    return Expanded(
      flex: 2,
      child: NeuBox(
          child: ValueListenableBuilder<ButtonState>(
        valueListenable: songPageLogic.playButtonNotifier,
        builder: (_, value, __) {
          switch (value) {
            case ButtonState.loading:
              return Container(
                margin: const EdgeInsets.all(8.0),
                width: 32.0,
                height: 32.0,
                child: const CircularProgressIndicator(),
              );
            case ButtonState.paused:
              return IconButton(
                icon: const Icon(Icons.play_arrow),
                iconSize: 32.0,
                onPressed: songPageLogic.play,
              );
            case ButtonState.playing:
              return IconButton(
                icon: const Icon(Icons.pause),
                iconSize: 32.0,
                onPressed: songPageLogic.pause,
              );
          }
        },
      )),
    );
  }
}

class NextSongButton extends StatelessWidget {
  const NextSongButton({super.key});

  @override
  Widget build(BuildContext context) {
    final songPageLogic = getIt<SongPageLogic>();
    return Expanded(
      child: ValueListenableBuilder<bool>(
        valueListenable: songPageLogic.isLastSongNotifier,
        builder: (_, isLast, __) {
          return GestureDetector(
            onTap: (isLast) ? null : songPageLogic.next,
            child: const NeuBox(
              child: Icon(Icons.skip_next),
            ),
          );
        },
      ),
    );
  }
}

class VolumeControlSlider extends StatelessWidget {
  const VolumeControlSlider({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.volume_up_rounded,
          color: Theme.of(context).colorScheme.primary,
        ),
        // Expanded(
        //   child: StreamBuilder(
        //     stream: player.volumeStream,
        //     builder: (context, snapshot) {
        //       return Slider(
        //         min: 0,
        //         max: 1,
        //         value: snapshot.data ?? 0.5,
        //         activeColor: Colors.green,
        //         inactiveColor: Theme.of(context).colorScheme.secondary,
        //         onChanged: (value) async {
        //           await player.setVolume(value);
        //         },
        //       );
        //     },
        //   ),
        // )
      ],
    );
  }
}
