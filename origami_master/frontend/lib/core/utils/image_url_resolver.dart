import '../config/app_config.dart';

/// Resolves an image URL that may be:
/// - Already absolute (http/https) → returned as-is
/// - A relative path starting with '/' → prefixed with [AppConfig.mediaBaseUrl]
/// - Empty or null → returns empty string
///
/// Example:
///   resolveImageUrl('/images/origami/crane.jpg')
///   → 'http://192.168.110.197:5097/images/origami/crane.jpg'
String resolveImageUrl(String? url) {
  if (url == null || url.isEmpty) return '';
  if (url.startsWith('http://') || url.startsWith('https://')) return url;
  // Relative path (e.g. /images/origami/crane.jpg)
  final base = AppConfig.mediaBaseUrl;
  final path = url.startsWith('/') ? url : '/$url';
  return '$base$path';
}
