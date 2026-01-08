import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/repositories/event_repository_impl.dart';
import '../../domain/entities/event_entity.dart';
import '../widgets/events_page/events_page_bottom_modal.dart';
import '../widgets/smart_image.dart';

class EventsPage extends StatefulWidget {
  final Function(int) onNavigate;

  const EventsPage({
    super.key,
    required this.onNavigate,
  });

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  late final EventRepositoryImpl _repository;

  @override
  void initState() {
    super.initState();
    _repository = EventRepositoryImpl(FirebaseFirestore.instance);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

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
          'Lịch Nhóm',
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.bar_chart_rounded,
              color: colorScheme.onSurface,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        color: colorScheme.surface,
        child: StreamBuilder<List<EventEntity>>(
          stream: _repository.watchActiveEvents(),
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
            final events = snapshot.data ?? [];
            if (events.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.event_busy,
                      size: 64,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Chưa có sự kiện nào',
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

            // Success state - use EventEntity directly
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              children: [
                // Banner - Use SmartImage instead of Image.asset
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: SmartImage(
                      imageUrl: 'assets/images/church.png', // Can be Firebase URL too
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 24),

                // Use EventEntity directly - no conversion needed
                ...events.map((event) {
                  return Column(
                    children: [
                      _EventListTile(
                        event: event,
                        onTap: () {
                          _showEventDetailBottomSheet(context, event);
                        },
                      ),
                      SizedBox(height: 16),
                      Divider(
                        height: 1,
                        thickness: 0.8,
                        color: colorScheme.outlineVariant,
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                }),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showEventDetailBottomSheet(BuildContext context, EventEntity event) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return EventDetailBottomSheet(event: event);
      },
    );
  }
}

/// List tile widget - uses EventEntity directly.
class _EventListTile extends StatelessWidget {
  final EventEntity event;
  final VoidCallback onTap;

  const _EventListTile({
    required this.event,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail - Use SmartImage
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 90,
                height: 70,
                child: SmartImage(
                  imageUrl: event.getThumbnailImage(),
                  fit: BoxFit.cover,
                  width: 90,
                  height: 70,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (event.subtitle != null) ...[
                    Text(
                      event.subtitle!,
                      style: TextStyle(
                        fontSize: 16,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],
                  if (event.dateDisplay != null)
                    Text(
                      event.dateDisplay!,
                      style: TextStyle(
                        fontSize: 14,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.chevron_right,
              color: colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}