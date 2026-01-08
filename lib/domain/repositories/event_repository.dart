import 'package:church_app/domain/entities/event_entity.dart';

/// Abstract repository defining the contract for event data operations.
/// Presentation layer depends on this abstraction, not the implementation.
abstract class EventRepository {
  /// Stream of active events, ordered by order field then startDateTime.
  /// Returns real-time updates from Firebase.
  Stream<List<EventEntity>> watchActiveEvents();
  
  /// Fetch a single event by ID.
  Future<EventEntity?> getEventById(String id);
  
  /// Create a new event (admin feature for future).
  Future<void> createEvent(EventEntity event);
  
  /// Update an existing event (admin feature for future).
  Future<void> updateEvent(EventEntity event);
  
  /// Soft delete an event by setting isActive to false.
  Future<void> deleteEvent(String id);
}