import 'package:flutter/material.dart';
import 'package:image_switch/data/image_data.dart';
import 'package:image_switch/data/image_repository.dart';
import 'package:image_switch/presentation/widgets/image_background.dart';
import 'package:image_switch/presentation/widgets/image_view.dart';
import 'package:image_switch/presentation/widgets/theme_notifier.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ImageSwitchPage extends StatefulWidget {
  final ImageRepository imageRepository;

  const ImageSwitchPage({
    super.key,
    required this.imageRepository,
  });

  @override
  State<ImageSwitchPage> createState() => _ImageSwitchPageState();
}

class _ImageSwitchPageState extends State<ImageSwitchPage> {
  ImageData? image;
  bool longerLoading = false;
  String? errorMessage;

  void fetchImage() async {
    try {
      setState(() {
        image = null;
        errorMessage = null;
      });
      final fetchedImage = await widget.imageRepository.getRandomImage();

      setState(() {
        image = fetchedImage;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchImage();
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = ThemeProvider.of(context);

    return Scaffold(
      body: ImageBackground(
        color: image?.dominantColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: ShapeDecoration(
                color: Theme.of(context).colorScheme.tertiary,
                shape: StadiumBorder(),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Text(
                'Image Switcher',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onTertiary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 32),
            ImageView(
              data: image,
              size: 400,
            ),
            const SizedBox(height: 32),
            if (errorMessage != null) ...[
              Text(errorMessage!, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 32),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 16,
              children: [
                FilledButton(
                  onPressed: fetchImage,
                  child: const Text('Another'),
                ),
                IconButton.filled(
                  onPressed: themeNotifier.toggleTheme,
                  icon: Icon(
                    themeNotifier.themeMode == ThemeMode.dark ? LucideIcons.sun : LucideIcons.moon,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Container(
              decoration: ShapeDecoration(
                color: Theme.of(context).colorScheme.tertiary,
                shape: StadiumBorder(),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Made by Richie Budijono',
                style: TextStyle(color: Theme.of(context).colorScheme.onTertiary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
