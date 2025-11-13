import 'dart:typed_data';
import 'dart:ui';

class ImageData {
  final String imageUrl;
  final Uint8List imageBytes;
  final Color? dominantColor;
  
  const ImageData({
    required this.imageUrl,
    required this.imageBytes,
    this.dominantColor,
  });
}
