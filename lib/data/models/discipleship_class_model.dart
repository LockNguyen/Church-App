import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/constants/firebase_constants.dart';
import '../../domain/entities/discipleship_class_entity.dart';

class DiscipleshipClassModel extends DiscipleshipClassEntity {
  const DiscipleshipClassModel({
    required super.id,
    required super.startTime,
    required super.endTime,
    super.contact,
    super.passage,
  });

  factory DiscipleshipClassModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    
    return DiscipleshipClassModel(
      id: doc.id,
      startTime: (data[FirebaseConstants.fieldStartTime] as Timestamp).toDate(),
      endTime: (data[FirebaseConstants.fieldEndTime] as Timestamp).toDate(),
      contact: data[FirebaseConstants.fieldContact] as String?,
      passage: data[FirebaseConstants.fieldPassage] as String?,
    );
  }
}