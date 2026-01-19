import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/constants/firebase_constants.dart';
import '../../domain/entities/discipleship_course_entity.dart';
import '../../domain/entities/discipleship_location_entity.dart';

/// Schema definition: /schemas/discipleship_course.schema.json
/// Generated type: /lib/data/models/generated/discipleship_course_generated.dart
class DiscipleshipCourseModel extends DiscipleshipCourseEntity {
  const DiscipleshipCourseModel({
    required super.id,
    required super.name,
    super.description,
    required super.locations,
  });

  factory DiscipleshipCourseModel.fromFirestore(
    DocumentSnapshot doc,
    List<DiscipleshipLocationEntity> locations,
  ) {
    final data = doc.data() as Map<String, dynamic>;
    
    return DiscipleshipCourseModel(
      id: doc.id,
      name: data[FirebaseConstants.fieldName] as String,
      description: data[FirebaseConstants.fieldDescription] as String?,
      locations: locations,
    );
  }
}