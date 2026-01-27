// This file was automatically generated from event.schema.json
// DO NOT MODIFY IT BY HAND. Run 'npm run generate:dart' to regenerate.

class Event {
  final String id;
  final String title;
  final String? subtitle;
  final String? dateDisplay;
  final String? heroImageUrl;
  final String? thumbnailImageUrl;
  final String? location;
  final String? notes;
  final DateTime? startDateTime;
  final DateTime? endDateTime;
  final bool isActive;
  final bool recurring;
  final double order;

  const Event({
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
    required this.recurring,
    required this.order,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      dateDisplay: json['dateDisplay'] as String?,
      heroImageUrl: json['heroImageUrl'] as String?,
      thumbnailImageUrl: json['thumbnailImageUrl'] as String?,
      location: json['location'] as String?,
      notes: json['notes'] as String?,
      startDateTime: json['startDateTime'] != null ? DateTime.parse(json['startDateTime'] as String) : null,
      endDateTime: json['endDateTime'] != null ? DateTime.parse(json['endDateTime'] as String) : null,
      isActive: json['isActive'] as bool,
      recurring: json['recurring'] as bool,
      order: (json['order'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'dateDisplay': dateDisplay,
      'heroImageUrl': heroImageUrl,
      'thumbnailImageUrl': thumbnailImageUrl,
      'location': location,
      'notes': notes,
      'startDateTime': startDateTime?.toIso8601String(),
      'endDateTime': endDateTime?.toIso8601String(),
      'isActive': isActive,
      'recurring': recurring,
      'order': order,
    };
  }

  Event copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? dateDisplay,
    String? heroImageUrl,
    String? thumbnailImageUrl,
    String? location,
    String? notes,
    DateTime? startDateTime,
    DateTime? endDateTime,
    bool? isActive,
    bool? recurring,
    double? order,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      dateDisplay: dateDisplay ?? this.dateDisplay,
      heroImageUrl: heroImageUrl ?? this.heroImageUrl,
      thumbnailImageUrl: thumbnailImageUrl ?? this.thumbnailImageUrl,
      location: location ?? this.location,
      notes: notes ?? this.notes,
      startDateTime: startDateTime ?? this.startDateTime,
      endDateTime: endDateTime ?? this.endDateTime,
      isActive: isActive ?? this.isActive,
      recurring: recurring ?? this.recurring,
      order: order ?? this.order,
    );
  }

  @override
  String toString() {
    return 'Event(id: $id, title: $title, subtitle: $subtitle, dateDisplay: $dateDisplay, heroImageUrl: $heroImageUrl, thumbnailImageUrl: $thumbnailImageUrl, location: $location, notes: $notes, startDateTime: $startDateTime, endDateTime: $endDateTime, isActive: $isActive, recurring: $recurring, order: $order)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Event &&
        other.id == id &&
        other.title == title &&
        other.subtitle == subtitle &&
        other.dateDisplay == dateDisplay &&
        other.heroImageUrl == heroImageUrl &&
        other.thumbnailImageUrl == thumbnailImageUrl &&
        other.location == location &&
        other.notes == notes &&
        other.startDateTime == startDateTime &&
        other.endDateTime == endDateTime &&
        other.isActive == isActive &&
        other.recurring == recurring &&
        other.order == order;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      title,
      subtitle,
      dateDisplay,
      heroImageUrl,
      thumbnailImageUrl,
      location,
      notes,
      startDateTime,
      endDateTime,
      isActive,
      recurring,
      order,
    );
  }
}
