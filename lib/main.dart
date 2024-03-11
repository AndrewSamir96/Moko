import 'package:flutter/material.dart';
import 'package:moko/pages/playlist_page/playlist_page.dart';
import 'package:moko/services/service_locator.dart';
import 'package:moko/services/settings_provider.dart';
import 'package:moko/pages/intro_page/intro_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await setupServiceLocator();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SettingsProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Provider.of<SettingsProvider>(context, listen: false).getSettings();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Moko',
      theme: Provider.of<SettingsProvider>(context).currTheme,
      home: Provider.of<SettingsProvider>(context, listen: false).isFirstTime
          ? const PlaylistPage()
          : const IntroPage(),
    );
  }
}
