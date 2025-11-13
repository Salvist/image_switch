import 'dart:async';
import 'package:web/web.dart' as html;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:js_interop';

/// Web-specific implementation using Canvas API for fast image processing
Future<Color?> getDominantColor(Uint8List bytes) async {
  final completer = Completer<Color?>();

  final blob = html.Blob([bytes.toJS].toJS);
  final url = html.URL.createObjectURL(blob);

  final imageElement = html.HTMLImageElement();
  imageElement.src = url;

  imageElement.onLoad.listen((_) {
    try {
      final canvas = html.HTMLCanvasElement()
        ..width = 16
        ..height = 16;
      final ctx = canvas.getContext('2d') as html.CanvasRenderingContext2D;

      ctx.drawImage(imageElement, 0, 0, 16, 16);

      final imageData = ctx.getImageData(0, 0, 16, 16);
      final data = imageData.data.toDart; // Convert JSUint8ClampedArray to Dart Uint8ClampedList

      int totalR = 0, totalG = 0, totalB = 0;
      int pixelCount = 0;

      for (int i = 0; i < data.length; i += 4) {
        totalR += data[i].round();
        totalG += data[i + 1].round();
        totalB += data[i + 2].round();
        pixelCount++;
      }

      final avgR = (totalR / pixelCount).round();
      final avgG = (totalG / pixelCount).round();
      final avgB = (totalB / pixelCount).round();

      // Clean up
      html.URL.revokeObjectURL(url);

      completer.complete(Color.fromRGBO(avgR, avgG, avgB, 1));
    } catch (e) {
      html.URL.revokeObjectURL(url);
      completer.completeError(e);
    }
  });

  imageElement.onError.listen((error) {
    html.URL.revokeObjectURL(url);
    // completer.completeError('Failed to get dominant color');
    completer.complete(null);
  });

  return completer.future;
}
