import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_switch/data/image_data.dart';
import 'package:image_switch/utils/get_dominant_color.dart';

const _imageEndpoint = 'https://november7-730026606190.europe-west1.run.app/image/';

class ImageRepository {
  const ImageRepository();

  Future<String> getRandomImageURL() async {
    final response = await http.get(Uri.parse(_imageEndpoint));
    final imageUrl = jsonDecode(response.body)['url'];

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return imageUrl;
    } else {
      throw Exception('Failed to get random image');
    }
  }

  Future<ImageData> getRandomImage() async {
    try {
      final imageUrl = await getRandomImageURL();
      final response = await http.get(Uri.parse(imageUrl));
      final imageBytes = response.bodyBytes;

      final dominantColor = await getDominantColor(imageBytes);
      return ImageData(
        imageUrl: imageUrl,
        imageBytes: imageBytes,
        dominantColor: dominantColor,
      );
    } catch (e) {
      throw Exception('Failed to get random image');
    }
  }
}
