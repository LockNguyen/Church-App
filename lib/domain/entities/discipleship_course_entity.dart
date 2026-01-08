import './discipleship_location_entity.dart';

/// Represents a discipleship course with multiple locations.
class DiscipleshipCourseEntity {
  final String id;
  final String name;
  final String? description;
  final List<DiscipleshipLocationEntity> locations;

  const DiscipleshipCourseEntity({
    required this.id,
    required this.name,
    this.description,
    required this.locations,
  });
}