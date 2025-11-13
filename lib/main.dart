import 'package:flutter/material.dart';
import 'package:image_switch/data/image_repository.dart';
import 'package:image_switch/presentation/image_switch_page.dart';
import 'package:image_switch/presentation/widgets/theme_notifier.dart';

void main() {
  const imageRepository = ImageRepository();
  final themeNotifier = ThemeNotifier();
  runApp(MainApp(imageRepository: imageRepository, themeNotifier: themeNotifier));
}

class MainApp extends StatelessWidget {
  final ImageRepository imageRepository;
  final ThemeNotifier themeNotifier;
  const MainApp({
    super.key,
    required this.imageRepository,
    required this.themeNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      themeNotifier: themeNotifier,
      child: ListenableBuilder(
        listenable: themeNotifier,
        builder: (context, child) {
          return MaterialApp(
            themeMode: themeNotifier.themeMode,
            home: ImageSwitchPage(
              imageRepository: imageRepository,
            ),
          );
        },
      ),
    );
  }
}
