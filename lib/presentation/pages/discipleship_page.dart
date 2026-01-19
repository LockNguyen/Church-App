import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/repositories/discipleship_repository_impl.dart';
import '../../domain/entities/discipleship_course_entity.dart';
import '../../domain/entities/discipleship_location_entity.dart';
import '../../l10n/generated/app_localizations.dart';
import '../widgets/discipleship_page/discipleship_location_bottom_modal.dart';
import '../widgets/smart_image.dart';

class DiscipleshipPage extends StatefulWidget {
  final Function(int) onNavigate;

  const DiscipleshipPage({
    super.key,
    required this.onNavigate,
  });

  @override
  State<DiscipleshipPage> createState() => _DiscipleshipPageState();
}

class _DiscipleshipPageState extends State<DiscipleshipPage> {
  late final DiscipleshipRepositoryImpl _repository;

  @override
  void initState() {
    super.initState();
    _repository = DiscipleshipRepositoryImpl(FirebaseFirestore.instance);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () => widget.onNavigate(0),
        ),
        centerTitle: true,
        title: Text(
          l10n.pageDiscipleshipTitle,
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        color: colorScheme.surface,
        child: StreamBuilder<List<DiscipleshipCourseEntity>>(
          stream: _repository.watchCourses(),
          builder: (context, snapshot) {
            // Loading state
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: colorScheme.primary,
                ),
              );
            }

            // Error state
            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: colorScheme.error,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Đã xảy ra lỗi',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        'Không thể tải dữ liệu. Vui lòng kiểm tra kết nối mạng.',
                        style: TextStyle(
                          fontSize: 14,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            }

            // Empty state
            final courses = snapshot.data ?? [];
            if (courses.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.school_outlined,
                      size: 64,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Chưa có khóa học nào',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              );
            }

            // Success state with data
            return ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 16),
              itemCount: courses.length,
              separatorBuilder: (context, index) => SizedBox(height: 8),
              itemBuilder: (context, index) {
                return _CourseExpansionTile(
                  course: courses[index],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

/// Expandable tile for a discipleship course.
class _CourseExpansionTile extends StatelessWidget {
  final DiscipleshipCourseEntity course;

  const _CourseExpansionTile({
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ExpansionTile(
      tilePadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      childrenPadding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
      title: Text(
        course.name,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: colorScheme.onSurface,
        ),
      ),
      subtitle: course.description != null
          ? Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                course.description!,
                style: TextStyle(
                  fontSize: 14,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            )
          : null,
      children: [
        ...course.locations.map((location) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _LocationCard(location: location),
          );
        }),
      ],
    );
  }
}

/// Location card styled like home page cards.
class _LocationCard extends StatelessWidget {
  final DiscipleshipLocationEntity location;

  const _LocationCard({
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (ctx) {
            return DiscipleshipLocationModal(location: location);
          },
        );
      },
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background image
              SmartImage(
                imageUrl: location.getThumbnailImage(),
                fit: BoxFit.cover,
              ),
              
              // Dark overlay
              Container(
                color: Colors.black.withOpacity(0.5),
              ),
              
              // Location name
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    location.name,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.8),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}