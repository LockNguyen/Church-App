/// Firebase collection and field name constants.
/// Centralized to avoid typos and enable easy refactoring.
class FirebaseConstants {
  // Events collection
  static const String eventsCollection = 'events';
  
  // Events fields
  static const String fieldId = 'id';
  static const String fieldTitle = 'title';
  static const String fieldSubtitle = 'subtitle';
  static const String fieldDateDisplay = 'dateDisplay';
  static const String fieldHeroImageUrl = 'heroImageUrl';
  static const String fieldThumbnailImageUrl = 'thumbnailImageUrl';
  static const String fieldLocation = 'location';
  static const String fieldNotes = 'notes';
  static const String fieldStartDateTime = 'startDateTime';
  static const String fieldEndDateTime = 'endDateTime';
  static const String fieldIsActive = 'isActive';
  static const String fieldCreatedAt = 'createdAt';
  static const String fieldUpdatedAt = 'updatedAt';
  static const String fieldOrder = 'order';

  // Discipleship collections
  static const String discipleshipCoursesCollection = 'discipleshipCourses';
  static const String discipleshipLocationsCollection = 'discipleshipLocations';
  static const String discipleshipClassesCollection = 'discipleshipClasses';
  
  // Discipleship fields
  static const String fieldName = 'name';
  static const String fieldDescription = 'description';
  static const String fieldStartTime = 'startTime';
  static const String fieldEndTime = 'endTime';
  static const String fieldContact = 'contact';
  static const String fieldPassage = 'passage';
}