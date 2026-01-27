// This file was automatically generated from discipleship-course.schema.json
// DO NOT MODIFY IT BY HAND. Run 'npm run generate:dart' to regenerate.

class DiscipleshipCourse {
  final String id;
  final String name;
  final String? description;

  const DiscipleshipCourse({
    required this.id,
    required this.name,
    this.description,
  });

  factory DiscipleshipCourse.fromJson(Map<String, dynamic> json) {
    return DiscipleshipCourse(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }

  DiscipleshipCourse copyWith({
    String? id,
    String? name,
    String? description,
  }) {
    return DiscipleshipCourse(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  @override
  String toString() {
    return 'DiscipleshipCourse(id: $id, name: $name, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DiscipleshipCourse &&
        other.id == id &&
        other.name == name &&
        other.description == description;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      name,
      description,
    );
  }
}
