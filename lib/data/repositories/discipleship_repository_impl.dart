import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/constants/firebase_constants.dart';
import '../../domain/entities/discipleship_course_entity.dart';
import '../../domain/entities/discipleship_location_entity.dart';
import '../../domain/entities/discipleship_class_entity.dart';
import '../../domain/repositories/discipleship_repository.dart';
import '../models/discipleship_course_model.dart';
import '../models/discipleship_location_model.dart';
import '../models/discipleship_class_model.dart';

class DiscipleshipRepositoryImpl implements DiscipleshipRepository {
  final FirebaseFirestore _firestore;

  DiscipleshipRepositoryImpl(this._firestore);

  @override
  Stream<List<DiscipleshipCourseEntity>> watchCourses() {
    return _firestore
        .collection(FirebaseConstants.discipleshipCoursesCollection)
        .snapshots()
        .asyncMap((courseSnapshot) async {
      final courses = <DiscipleshipCourseEntity>[];

      for (var courseDoc in courseSnapshot.docs) {
        // Get locations for this course
        final locationsSnapshot = await courseDoc.reference
            .collection(FirebaseConstants.discipleshipLocationsCollection)
            .get();

        final locations = <DiscipleshipLocationEntity>[];

        for (var locationDoc in locationsSnapshot.docs) {
          // Get classes for this location
          final classesSnapshot = await locationDoc.reference
              .collection(FirebaseConstants.discipleshipClassesCollection)
              .orderBy(FirebaseConstants.fieldStartTime)
              .get();

          final classes = classesSnapshot.docs
              .map((doc) => DiscipleshipClassModel.fromFirestore(doc))
              .toList();

          // Only add location if it has classes
          if (classes.isNotEmpty) {
            locations.add(
              DiscipleshipLocationModel.fromFirestore(locationDoc, classes),
            );
          }
        }

        // Only add course if it has locations with classes
        if (locations.isNotEmpty) {
          courses.add(
            DiscipleshipCourseModel.fromFirestore(courseDoc, locations),
          );
        }
      }

      return courses;
    });
  }
}