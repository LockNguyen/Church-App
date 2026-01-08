import '../entities/discipleship_course_entity.dart';

/// Abstract repository for discipleship data operations.
abstract class DiscipleshipRepository {
  /// Stream of all discipleship courses with nested locations and classes.
  Stream<List<DiscipleshipCourseEntity>> watchCourses();
}