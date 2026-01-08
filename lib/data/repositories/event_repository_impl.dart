import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/constants/firebase_constants.dart';
import '../../domain/entities/event_entity.dart';
import '../../domain/repositories/event_repository.dart';
import '../models/event_model.dart';

/// Concrete implementation of EventRepository using Firebase Firestore.
/// This class can be swapped with other implementations (e.g., local database)
/// without affecting the presentation layer.
class EventRepositoryImpl implements EventRepository {
  final FirebaseFirestore _firestore;

  // Remove the settings configuration from here
  EventRepositoryImpl(this._firestore);

  // EventRepositoryImpl(FirebaseFirestore firestore) 
  //     : _firestore = firestore {
  //   // Enable offline persistence
  //   _firestore.settings = const Settings(
  //     persistenceEnabled: true,
  //     cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  //   );
  // }

  @override
  Stream<List<EventEntity>> watchActiveEvents() {
    return _firestore
        .collection(FirebaseConstants.eventsCollection)
        .where(FirebaseConstants.fieldIsActive, isEqualTo: true)
        .orderBy(FirebaseConstants.fieldOrder)
        .orderBy(FirebaseConstants.fieldStartDateTime, descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => EventModel.fromFirestore(doc))
          .toList();
    });
  }

  @override
  Future<EventEntity?> getEventById(String id) async {
    try {
      final doc = await _firestore
          .collection(FirebaseConstants.eventsCollection)
          .doc(id)
          .get();
      
      if (!doc.exists) return null;
      
      return EventModel.fromFirestore(doc);
    } catch (e) {
      throw Exception('Failed to fetch event: $e');
    }
  }

  @override
  Future<void> createEvent(EventEntity event) async {
    try {
      final docRef = _firestore
          .collection(FirebaseConstants.eventsCollection)
          .doc();
      
      final eventModel = EventModel(
        id: docRef.id,
        title: event.title,
        subtitle: event.subtitle,
        dateDisplay: event.dateDisplay,
        heroImageUrl: event.heroImageUrl,
        thumbnailImageUrl: event.thumbnailImageUrl,
        location: event.location,
        notes: event.notes,
        startDateTime: event.startDateTime,
        endDateTime: event.endDateTime,
        isActive: event.isActive,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        order: event.order,
      );
      
      await docRef.set(eventModel.toFirestore());
    } catch (e) {
      throw Exception('Failed to create event: $e');
    }
  }

  @override
  Future<void> updateEvent(EventEntity event) async {
    try {
      await _firestore
          .collection(FirebaseConstants.eventsCollection)
          .doc(event.id)
          .update({
        ...EventModel(
          id: event.id,
          title: event.title,
          subtitle: event.subtitle,
          dateDisplay: event.dateDisplay,
          heroImageUrl: event.heroImageUrl,
          thumbnailImageUrl: event.thumbnailImageUrl,
          location: event.location,
          notes: event.notes,
          startDateTime: event.startDateTime,
          endDateTime: event.endDateTime,
          isActive: event.isActive,
          createdAt: event.createdAt,
          updatedAt: DateTime.now(),
          order: event.order,
        ).toFirestore(),
      });
    } catch (e) {
      throw Exception('Failed to update event: $e');
    }
  }

  @override
  Future<void> deleteEvent(String id) async {
    try {
      await _firestore
          .collection(FirebaseConstants.eventsCollection)
          .doc(id)
          .update({
        FirebaseConstants.fieldIsActive: false,
        FirebaseConstants.fieldUpdatedAt: Timestamp.now(),
      });
    } catch (e) {
      throw Exception('Failed to delete event: $e');
    }
  }
}