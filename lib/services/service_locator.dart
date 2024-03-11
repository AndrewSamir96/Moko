import 'package:audio_service/audio_service.dart';
import 'package:get_it/get_it.dart';
import 'package:moko/pages/song_page/song_page_logic.dart';
import 'package:moko/services/audio_handler.dart';
import 'package:moko/services/playlist_repository.dart';

GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // services
  getIt.registerSingleton<AudioHandler>(await initAudioService());
  getIt.registerLazySingleton<PlaylistRepository>(() => DemoPlaylist());
  // page state
  getIt.registerLazySingleton<SongPageLogic>(() => SongPageLogic());
}
