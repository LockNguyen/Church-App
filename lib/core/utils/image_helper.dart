/// Centralized image loading logic.
/// Handles Firebase Storage URLs, asset paths, and fallbacks.
class ImageHelper {
  // Regex to detect HTTP(S) URLs
  static final _urlPattern = RegExp(r'^https?://');
  
  /// Check if a string is a network URL.
  static bool isNetworkUrl(String? url) {
    if (url == null || url.isEmpty) return false;
    return _urlPattern.hasMatch(url);
  }
  
  /// Get fallback image path based on context.
  static String getDefaultHeroImage() {
    return 'assets/images/church.png';
  }
  
  static String getDefaultThumbnail() {
    return 'assets/images/placeholder.png';
  }
  
  /// Determine the best image to use from multiple sources.
  static String getBestImage(
    String? primary,
    String? secondary,
    String defaultPath,
  ) {
    if (primary != null && primary.isNotEmpty) return primary;
    if (secondary != null && secondary.isNotEmpty) return secondary;
    return defaultPath;
  }
}