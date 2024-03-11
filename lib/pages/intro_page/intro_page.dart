import 'package:flutter/material.dart';
import 'package:moko/pages/playlist_page/playlist_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Intro Screen'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                prefs.setBool('seen', true);
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlaylistPage(),
                    ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.black,
              ),
              child: const Text('Continue'),
            )
          ],
        ),
      ),
    );
  }
}
