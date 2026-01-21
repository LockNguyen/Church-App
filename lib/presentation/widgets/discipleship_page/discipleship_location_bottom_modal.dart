import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../domain/entities/discipleship_class_entity.dart';
import '../../../domain/entities/discipleship_location_entity.dart';
import '../../../core/utils/time_formatter.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../smart_image.dart';

class DiscipleshipLocationModal extends StatelessWidget {
  final DiscipleshipLocationEntity location;

  const DiscipleshipLocationModal({
    super.key,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return DraggableScrollableSheet(
      initialChildSize: 0.94,
      minChildSize: 0.8,
      maxChildSize: 0.98,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Column(
            children: [
              // Top app bar
              Padding(
                padding: const EdgeInsets.only(
                  top: 12,
                  left: 8,
                  right: 8,
                  bottom: 4,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: colorScheme.onSurface,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        location.name,
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 48), // Balance for back button
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 8),

                      // Hero image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: SmartImage(
                            imageUrl: location.getThumbnailImage(),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Classes header
                      Text(
                        l10n.sectionClasses,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // List of classes
                      ...location.classes.asMap().entries.map((entry) {
                        final index = entry.key;
                        final classEntity = entry.value;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: _ClassCard(
                            classNumber: index + 1,
                            classEntity: classEntity,
                          ),
                        );
                      }),

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Card displaying a single class with its details.
class _ClassCard extends StatelessWidget {
  final int classNumber;
  final DiscipleshipClassEntity classEntity;

  const _ClassCard({
    required this.classNumber,
    required this.classEntity,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Class title
          Text(
            'Lớp $classNumber',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 12),

          // Time
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 20,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  TimeFormatter.formatClassTimeRange(
                    classEntity.startTime,
                    classEntity.endTime,
                    Localizations.localeOf(context).languageCode,
                  ),
                  style: TextStyle(
                    fontSize: 16,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),

          // Passage
          if (classEntity.passage != null) ...[
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.menu_book,
                  size: 20,
                  color: colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    classEntity.passage!,
                    style: TextStyle(
                      fontSize: 16,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ],

          // Contact (clickable)
          if (classEntity.contact != null) ...[
            const SizedBox(height: 12),
            InkWell(
              onTap: () => _handleContactTap(context, classEntity.contact!),
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Icon(
                      _getContactIcon(classEntity.contact!),
                      size: 20,
                      color: colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        classEntity.contact!,
                        style: TextStyle(
                          fontSize: 16,
                          color: colorScheme.primary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Determine icon based on contact type.
  IconData _getContactIcon(String contact) {
    if (contact.contains('@')) {
      return Icons.email;
    } else if (contact.replaceAll(RegExp(r'[^\d]'), '').length >= 10) {
      return Icons.phone;
    }
    return Icons.contact_page;
  }

  /// Handle contact tap - launch phone or email.
  Future<void> _handleContactTap(BuildContext context, String contact) async {
    final Uri? uri;
    
    // Detect if email or phone
    if (contact.contains('@')) {
      uri = Uri.parse('mailto:$contact');
    } else {
      // Remove non-digit characters for phone number
      final phone = contact.replaceAll(RegExp(r'[^\d]'), '');
      uri = Uri.parse('tel:$phone');
    }

    final l10n = AppLocalizations.of(context)!;

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.errorCannotOpen(contact)),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.errorUnknown(e.toString())),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }
}