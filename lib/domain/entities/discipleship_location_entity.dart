
import './discipleship_class_entity.dart';

/// Represents a location where discipleship classes are held.
class DiscipleshipLocationEntity {
  final String id;
  final String name;
  final String? thumbnailImageUrl;
  final List<DiscipleshipClassEntity> classes;

  const DiscipleshipLocationEntity({
    required this.id,
    required this.name,
    this.thumbnailImageUrl,
    required this.classes,
  });
  
  /// Get thumbnail with fallback.
  String getThumbnailImage() {
    if (thumbnailImageUrl != null && thumbnailImageUrl!.isNotEmpty) {
      return thumbnailImageUrl!;
    }
    return 'assets/images/placeholder.png';
  }
}