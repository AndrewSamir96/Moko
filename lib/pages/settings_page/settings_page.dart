import 'package:flutter/material.dart';
import 'package:moko/services/settings_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('S E T T I N G S'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Dark Mode',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Switch(
                  value: Provider.of<SettingsProvider>(context, listen: false)
                      .isDarkMode,
                  onChanged: (value) {
                    setState(() {
                      Provider.of<SettingsProvider>(context, listen: false)
                          .toggleTheme();
                    });
                  },
                  activeColor: Colors.green,
                ),
              ],
            ),
            // const SizedBox(height: 12),
            // Material(
            //   type: MaterialType.transparency,
            //   child: ListTile(
            //     leading: const Icon(Icons.folder),
            //     title: const Text('Set Default Folder'),
            //     subtitle: const Text(
            //         'Select the defualt directory to play music from'),
            //     onTap: () {},
            //   ),
            // ),
            const SizedBox(height: 12),
            // Text(data)
            // Material(
            //   type: MaterialType.transparency,
            //   child: InkWell(
            //     onTap: () {},
            //     child: Container(
            //       padding: const EdgeInsets.all(5),
            //       child: const Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text('Set Default Folder',
            //               style: TextStyle(fontWeight: FontWeight.bold)),
            //           Text('Select the defualt directory to play music from'),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
