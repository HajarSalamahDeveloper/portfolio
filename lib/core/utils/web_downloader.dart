import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:flutter/services.dart';

/// Utility class for downloading files on web platform
class WebDownloader {
  /// Downloads a PDF file from assets
  static Future<void> downloadPdf({
    required String assetPath,
    required String fileName,
  }) async {
    try {
      // Load the PDF from assets
      final byteData = await rootBundle.load(assetPath);
      final bytes = byteData.buffer.asUint8List();

      // Create a blob and download link
      final blob = html.Blob([bytes], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);

      // Create and click the download link
      html.AnchorElement(href: url)
        ..setAttribute('download', fileName)
        ..click();

      // Clean up the URL
      html.Url.revokeObjectUrl(url);
    } catch (e) {
      // Fallback: open PDF in new tab
      final byteData = await rootBundle.load(assetPath);
      final bytes = byteData.buffer.asUint8List();
      final base64 = base64Encode(bytes);
      final dataUrl = 'data:application/pdf;base64,$base64';

      html.window.open(dataUrl, '_blank');
    }
  }
}
