import 'package:url_launcher/url_launcher.dart';

/// Helper class for launching URLs
class UrlLauncherHelper {
  UrlLauncherHelper._();

  /// Launch a URL in the browser
  static Future<bool> launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
    return false;
  }

  /// Launch email client
  static Future<bool> launchEmail(
    String email, {
    String? subject,
    String? body,
  }) async {
    final uri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        if (subject != null) 'subject': subject,
        if (body != null) 'body': body,
      },
    );

    if (await canLaunchUrl(uri)) {
      return await launchUrl(uri);
    }
    return false;
  }

  /// Launch phone dialer
  static Future<bool> launchPhone(String phoneNumber) async {
    final uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      return await launchUrl(uri);
    }
    return false;
  }

  /// Launch GitHub profile
  static Future<bool> launchGitHub(String username) async {
    return await launchURL('https://github.com/$username');
  }

  /// Launch Play Store app
  static Future<bool> launchPlayStore(String packageName) async {
    return await launchURL(
      'https://play.google.com/store/apps/details?id=$packageName',
    );
  }
}
