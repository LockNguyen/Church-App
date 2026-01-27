// This file was automatically generated from discipleship-location.schema.json
// DO NOT MODIFY IT BY HAND. Run 'npm run generate:dart' to regenerate.

class DiscipleshipLocation {
  final String id;
  final String courseId;
  final String name;
  final String? thumbnailImageUrl;

  const DiscipleshipLocation({
    required this.id,
    required this.courseId,
    required this.name,
    this.thumbnailImageUrl,
  });

  factory DiscipleshipLocation.fromJson(Map<String, dynamic> json) {
    return DiscipleshipLocation(
      id: json['id'] as String,
      courseId: json['courseId'] as String,
      name: json['name'] as String,
      thumbnailImageUrl: json['thumbnailImageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'courseId': courseId,
      'name': name,
      'thumbnailImageUrl': thumbnailImageUrl,
    };
  }

  DiscipleshipLocation copyWith({
    String? id,
    String? courseId,
    String? name,
    String? thumbnailImageUrl,
  }) {
    return DiscipleshipLocation(
      id: id ?? this.id,
      courseId: courseId ?? this.courseId,
      name: name ?? this.name,
      thumbnailImageUrl: thumbnailImageUrl ?? this.thumbnailImageUrl,
    );
  }

  @override
  String toString() {
    return 'DiscipleshipLocation(id: $id, courseId: $courseId, name: $name, thumbnailImageUrl: $thumbnailImageUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DiscipleshipLocation &&
        other.id == id &&
        other.courseId == courseId &&
        other.name == name &&
        other.thumbnailImageUrl == thumbnailImageUrl;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      courseId,
      name,
      thumbnailImageUrl,
    );
  }
}
