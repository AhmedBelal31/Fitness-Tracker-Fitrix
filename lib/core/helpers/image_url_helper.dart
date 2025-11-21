class ImageUrlHelper {
  // Base URL for images
  static const String baseUrl = 'https://gymassistantapi.runasp.net';

  /// Converts a relative image URL to a full URL
  /// If the URL already contains the base URL or is a full URL, returns it as is
  static String getFullImageUrl(String? imageUrl) {
    // Return empty string if null
    if (imageUrl == null || imageUrl.isEmpty) {
      return '';
    }

    // If already a full URL (contains http:// or https://), return as is
    if (imageUrl.startsWith('http://') || imageUrl.startsWith('https://')) {
      return imageUrl;
    }

    // If starts with /, it's a relative path - add base URL
    if (imageUrl.startsWith('/')) {
      return '$baseUrl$imageUrl';
    }

    // If doesn't start with /, add base URL with /
    return '$baseUrl/$imageUrl';
  }

  /// Checks if an image URL is valid (not null and not empty)
  static bool isValidImageUrl(String? imageUrl) {
    return imageUrl != null && imageUrl.isNotEmpty;
  }

  /// Gets a placeholder image URL when no image is available
  static String getPlaceholderImageUrl() {
    return ''; // Return empty for now, can add a default placeholder later
  }
}
