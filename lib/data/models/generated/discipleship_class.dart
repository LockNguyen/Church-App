// This file was automatically generated from discipleship-class.schema.json
// DO NOT MODIFY IT BY HAND. Run 'npm run generate:dart' to regenerate.

class DiscipleshipClass {
  final String id;
  final String courseId;
  final String locationId;
  final DateTime startTime;
  final DateTime endTime;
  final String? contact;
  final String? passage;

  const DiscipleshipClass({
    required this.id,
    required this.courseId,
    required this.locationId,
    required this.startTime,
    required this.endTime,
    this.contact,
    this.passage,
  });

  factory DiscipleshipClass.fromJson(Map<String, dynamic> json) {
    return DiscipleshipClass(
      id: json['id'] as String,
      courseId: json['courseId'] as String,
      locationId: json['locationId'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      contact: json['contact'] as String?,
      passage: json['passage'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'courseId': courseId,
      'locationId': locationId,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'contact': contact,
      'passage': passage,
    };
  }

  DiscipleshipClass copyWith({
    String? id,
    String? courseId,
    String? locationId,
    DateTime? startTime,
    DateTime? endTime,
    String? contact,
    String? passage,
  }) {
    return DiscipleshipClass(
      id: id ?? this.id,
      courseId: courseId ?? this.courseId,
      locationId: locationId ?? this.locationId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      contact: contact ?? this.contact,
      passage: passage ?? this.passage,
    );
  }

  @override
  String toString() {
    return 'DiscipleshipClass(id: $id, courseId: $courseId, locationId: $locationId, startTime: $startTime, endTime: $endTime, contact: $contact, passage: $passage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DiscipleshipClass &&
        other.id == id &&
        other.courseId == courseId &&
        other.locationId == locationId &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.contact == contact &&
        other.passage == passage;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      courseId,
      locationId,
      startTime,
      endTime,
      contact,
      passage,
    );
  }
}
