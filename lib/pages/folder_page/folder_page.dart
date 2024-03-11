import 'package:file_picker/file_picker.dart';
import 'package:files_scanner_android/files_scanner_android.dart';
import 'package:flutter/material.dart';
import 'package:moko/widgets/my_drawer.dart';
import 'dart:io';

class FolderPage extends StatefulWidget {
  const FolderPage({super.key});
  @override
  State<FolderPage> createState() => FolderPageState();
}

class FolderPageState extends State<FolderPage> {
  void chooseDirectory() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    if (selectedDirectory != null) {
      var myDir = Directory(selectedDirectory);
      print(myDir);
      // FileScanner.getFilesByExtension(selectedDirectory, [".mp3"])
      //     .then((value) => print(value));
      final folder =
          await myDir.list(recursive: true, followLinks: false).toList();
      print(folder);
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text(selectedDirectory)));
    }
  }

  void handleClick(int item) {
    switch (item) {
      case 0:
        chooseDirectory();
        break;
      case 1:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('F O L D E R S'),
          centerTitle: true,
          actions: [
            PopupMenuButton<int>(
              onSelected: (item) => handleClick(item),
              itemBuilder: (context) => [
                const PopupMenuItem<int>(
                    value: 0, child: Text('Choose Directory')),
              ],
            ),
          ]),
      drawer: const MyDrawer(),
      body: const Center(
        child: Text('Folder Page'),
      ),
    );
  }
}
