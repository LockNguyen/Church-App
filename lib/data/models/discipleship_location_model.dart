import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/constants/firebase_constants.dart';
import '../../domain/entities/discipleship_location_entity.dart';
import '../../domain/entities/discipleship_class_entity.dart';

class DiscipleshipLocationModel extends DiscipleshipLocationEntity {
  const DiscipleshipLocationModel({
    required super.id,
    required super.name,
    super.thumbnailImageUrl,
    required super.classes,
  });

  factory DiscipleshipLocationModel.fromFirestore(
    DocumentSnapshot doc,
    List<DiscipleshipClassEntity> classes,
  ) {
    final data = doc.data() as Map<String, dynamic>;
    
    return DiscipleshipLocationModel(
      id: doc.id,
      name: data[FirebaseConstants.fieldName] as String,
      thumbnailImageUrl: data[FirebaseConstants.fieldThumbnailImageUrl] as String?,
      classes: classes,
    );
  }
}