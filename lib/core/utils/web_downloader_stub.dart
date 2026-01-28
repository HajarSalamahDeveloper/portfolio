/// Stub file for non-web platforms
/// This file provides a no-op implementation for platforms that don't support
/// dart:html
class WebDownloader {
  /// Downloads a PDF file from assets (stub - does nothing on non-web)
  static Future<void> downloadPdf({
    required String assetPath,
    required String fileName,
  }) async {
    // No-op on non-web platforms
  }
}
