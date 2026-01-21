import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/constants/firebase_constants.dart';
import '../../domain/entities/event_entity.dart';

/// Data model that handles Firebase serialization.
/// Extends EventEntity to avoid duplication.
///
/// Schema definition: /schemas/event.schema.json
/// Generated type: /lib/data/models/generated/event_generated.dart
class EventModel extends EventEntity {
  const EventModel({
    required super.id,
    required super.title,
    super.subtitle,
    super.dateDisplay,
    super.heroImageUrl,
    super.thumbnailImageUrl,
    super.location,
    super.notes,
    super.startDateTime,
    super.endDateTime,
    required super.isActive,
    required super.createdAt,
    required super.updatedAt,
    required super.order,
  });

  /// Single conversion point: Firestore → EventModel.
  /// This is the ONLY place we deserialize Firebase data.
  factory EventModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    
    return EventModel(
      id: doc.id,
      title: data[FirebaseConstants.fieldTitle] as String,
      subtitle: _getStringOrNull(data[FirebaseConstants.fieldSubtitle]),
      dateDisplay: _getStringOrNull(data[FirebaseConstants.fieldDateDisplay]),
      heroImageUrl: _getStringOrNull(data[FirebaseConstants.fieldHeroImageUrl]),
      thumbnailImageUrl: _getStringOrNull(data[FirebaseConstants.fieldThumbnailImageUrl]),
      location: _getStringOrNull(data[FirebaseConstants.fieldLocation]),
      notes: _getStringOrNull(data[FirebaseConstants.fieldNotes]),
      startDateTime: (data[FirebaseConstants.fieldStartDateTime] as Timestamp?)?.toDate(),
      endDateTime: (data[FirebaseConstants.fieldEndDateTime] as Timestamp?)?.toDate(),
      isActive: data[FirebaseConstants.fieldIsActive] as bool? ?? true,
      createdAt: (data[FirebaseConstants.fieldCreatedAt] as Timestamp).toDate(),
      updatedAt: (data[FirebaseConstants.fieldUpdatedAt] as Timestamp).toDate(),
      order: data[FirebaseConstants.fieldOrder] as int? ?? 0,
    );
  }

  /// Single conversion point: EventModel → Firestore.
  Map<String, dynamic> toFirestore() {
    return {
      FirebaseConstants.fieldTitle: title,
      FirebaseConstants.fieldSubtitle: subtitle,
      FirebaseConstants.fieldDateDisplay: dateDisplay,
      FirebaseConstants.fieldHeroImageUrl: heroImageUrl,
      FirebaseConstants.fieldThumbnailImageUrl: thumbnailImageUrl,
      FirebaseConstants.fieldLocation: location,
      FirebaseConstants.fieldNotes: notes,
      FirebaseConstants.fieldStartDateTime: startDateTime != null 
          ? Timestamp.fromDate(startDateTime!) 
          : null,
      FirebaseConstants.fieldEndDateTime: endDateTime != null 
          ? Timestamp.fromDate(endDateTime!) 
          : null,
      FirebaseConstants.fieldIsActive: isActive,
      FirebaseConstants.fieldCreatedAt: Timestamp.fromDate(createdAt),
      FirebaseConstants.fieldUpdatedAt: Timestamp.fromDate(updatedAt),
      FirebaseConstants.fieldOrder: order,
    };
  }

  /// Helper to handle empty strings from Firestore.
  static String? _getStringOrNull(dynamic value) {
    if (value == null) return null;
    if (value is! String) return null;
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }
}