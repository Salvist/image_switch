import 'package:flutter/material.dart';
import 'package:image_switch/data/image_data.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ImageView extends StatefulWidget {
  final ImageData? data;
  final double size;

  const ImageView({
    super.key,
    required this.data,
    required this.size,
  });

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> with TickerProviderStateMixin {
  late AnimationController _floatController;
  late AnimationController _rotateController;
  late Animation<double> _floatAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();

    // Float animation (vertical movement)
    _floatController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _floatAnimation =
        Tween<double>(
          begin: -20,
          end: 20,
        ).animate(
          CurvedAnimation(
            parent: _floatController,
            curve: Curves.easeInOut,
          ),
        );

    // Rotate animation (subtle rotation)
    _rotateController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _rotateAnimation =
        Tween<double>(
          begin: -0.2,
          end: 0.4,
        ).animate(
          CurvedAnimation(parent: _rotateController, curve: Curves.easeInOut),
        );

    _floatController.repeat(reverse: true);
    _rotateController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _floatController.dispose();
    _rotateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget child;

    if (widget.data == null) {
      child = AnimatedBuilder(
        animation: Listenable.merge([_floatController, _rotateController]),
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _floatAnimation.value),
            child: Transform.rotate(
              angle: _rotateAnimation.value,
              child: Icon(
                LucideIcons.sparkles,
                size: widget.size * 0.4,
                color: Colors.grey.shade400,
              ),
            ),
          );
        },
      );
    } else {
      child = Image.memory(
        widget.data!.imageBytes,
        fit: BoxFit.cover,
        width: widget.size,
        height: widget.size,
        errorBuilder: (context, error, stackTrace) {
          return Text(
            'Failed to load image.\n'
            'Please try fetching again.',
            textAlign: TextAlign.center,
          );
        },
      );
    }

    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: Colors.grey.shade50,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        child: Center(child: child),
      ),
    );
  }
}
