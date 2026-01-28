import 'dart:convert';
import 'dart:js_interop';
import 'package:flutter/services.dart';
import 'package:web/web.dart' as web;

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
      final blob = web.Blob(
        [bytes.toJS].toJS,
        web.BlobPropertyBag(type: 'application/pdf'),
      );
      final url = web.URL.createObjectURL(blob);

      // Create and click the download link
      final anchor = web.document.createElement('a') as web.HTMLAnchorElement;
      anchor.href = url;
      anchor.download = fileName;
      anchor.click();

      // Clean up the URL
      web.URL.revokeObjectURL(url);
    } catch (e) {
      // Fallback: open PDF in new tab
      final byteData = await rootBundle.load(assetPath);
      final bytes = byteData.buffer.asUint8List();
      final base64 = base64Encode(bytes);
      final dataUrl = 'data:application/pdf;base64,$base64';

      web.window.open(dataUrl, '_blank');
    }
  }
}
