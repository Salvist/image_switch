import 'package:flutter/material.dart';
import 'package:image_switch/presentation/widgets/theme_notifier.dart';

class ImageBackground extends StatelessWidget {
  final Color? color;
  final Widget child;
  const ImageBackground({
    super.key,
    this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final themeNotifier = ThemeProvider.of(context);
    final outerColor = themeNotifier.themeMode == ThemeMode.dark ? Colors.black54 : Colors.white;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 1.0,
          colors: [
            color ?? Colors.white,
            outerColor,
          ],
          stops: const [0.1, 1.0],
        ),
      ),
      width: double.infinity,
      height: double.infinity,
      child: child,
    );
  }
}
