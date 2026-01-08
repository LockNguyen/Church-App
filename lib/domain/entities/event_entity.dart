import '../../core/utils/image_helper.dart';

/// Pure business entity representing an Event.
class EventEntity {
  final String id;
  final String title;
  final String? subtitle;
  final String? dateDisplay;
  final String? heroImageUrl;      // Now Firebase Storage URL or asset path
  final String? thumbnailImageUrl; // Now Firebase Storage URL or asset path
  final String? location;
  final String? notes;
  final DateTime? startDateTime;
  final DateTime? endDateTime;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int order;

  const EventEntity({
    required this.id,
    required this.title,
    this.subtitle,
    this.dateDisplay,
    this.heroImageUrl,
    this.thumbnailImageUrl,
    this.location,
    this.notes,
    this.startDateTime,
    this.endDateTime,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.order,
  });
  
  /// Get the best hero image URL with intelligent fallback.
  /// Returns Firebase Storage URL, asset path, or default.
  String getHeroImage() {
    return ImageHelper.getBestImage(
      heroImageUrl,
      thumbnailImageUrl,
      ImageHelper.getDefaultHeroImage(),
    );
  }
  
  /// Get the best thumbnail image URL with intelligent fallback.
  /// Returns Firebase Storage URL, asset path, or default.
  String getThumbnailImage() {
    return ImageHelper.getBestImage(
      thumbnailImageUrl,
      heroImageUrl,
      ImageHelper.getDefaultThumbnail(),
    );
  }
}