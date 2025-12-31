import 'package:flutter/material.dart';
import '../widgets/events_page/events_page_bottom_modal.dart';

class EventsPage extends StatelessWidget {
  // Navigation callback to communicate with MainNavigation
  final Function(int) onNavigate;

  const EventsPage({
    super.key,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // Fake data for now – later you can replace this with real models.
    final events = [
      EventItem(
        title: 'Học Kinh Thánh Môn Đồ Hóa',
        heroImage: 'assets/images/praying.jpg',
        thumbnailImage: 'assets/images/praying.jpg',
        notes: '\nLớp 1:\n- Thời Gian: T6, 2 thg 1 • 6:00 – 7:00pm\n- Địa Điểm: 4680 Willow Ct, Winston Salem, NC 27103\n- Liên Hệ: MS Nghiêm\n\nLớp 2:\n- Thời Gian: T6, 2 thg 1 • 8:00 – 9:00pm\n- Địa Điểm: 1111 Hello St, Winston Salem, NC 27103\n- Liên Hệ: MS Khuê',
      ),
      EventItem(
        title: 'Tập Hát',
        dateDisplay: 'T7, 3 thg 1 • 8:00 – 9:00pm',
        heroImage: 'assets/images/youth_worship_practice.jpg', // replace with your banner image
        thumbnailImage: 'assets/images/youth_worship_practice.jpg',
        location: '134 S Peace Haven Rd, Winston Salem, NC 27104',
      ),
      EventItem(
        title: 'Lớp Môn Đồ Hóa',
        dateDisplay: 'CN, 4 thg 1 • 9:15 – 10:15am',
        heroImage: 'assets/images/khue_and_youth.jpg', // replace with your banner image
        thumbnailImage: 'assets/images/khue_and_youth.jpg',
        location: '134 S Peace Haven Rd, Winston Salem, NC 27104',
      ),
      EventItem(
        title: 'Thờ Phượng',
        dateDisplay: 'CN, 4 thg 1 • 10:30 – 11:30am',
        heroImage: 'assets/images/meredith_na_duet.jpg',
        thumbnailImage: 'assets/images/meredith_na_duet.jpg',
        location: '134 S Peace Haven Rd, Winston Salem, NC 27104',
      )
    ];

    return Scaffold(
      // This AppBar is only for the Events tab; MainNavigation does not add an AppBar.
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          // Go back to Home tab (index 0) in your MainNavigation.
          onPressed: () => onNavigate(0),
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
        color: colorScheme.surface, // solid background like the screenshot
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          children: [
            // Top banner image
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.asset(
                  'assets/images/church.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Event list items
            ...events.map(
              (event) => Column(
                children: [
                  _EventListTile(
                    event: event,
                    onTap: () {
                      _showEventDetailBottomSheet(context, event);
                    },
                  ),
                  const SizedBox(height: 16),
                  // Divider like in the screenshot
                  Divider(
                    height: 1,
                    thickness: 0.8,
                    color: colorScheme.outlineVariant,
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEventDetailBottomSheet(BuildContext context, EventItem event) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // full-height sheet
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return EventDetailBottomSheet(event: event);
      },
    );
  }
}

/// Simple data holder for the event.
/// Later you can move this to a separate models file.
class EventItem {
  final String title;
  final String? subtitle;
  final String? dateDisplay;
  final String heroImage;
  final String thumbnailImage;
  final String? location;
  final String? notes;

  const EventItem({
    required this.title,
    this.subtitle,
    this.dateDisplay,
    required this.heroImage,
    required this.thumbnailImage,
    this.location,
    this.notes,
  });
}

/// List tile that visually matches the first screenshot.
class _EventListTile extends StatelessWidget {
  final EventItem event;
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
            // Thumbnail with the date badge over it (simplified for now).
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 90,
                height: 70,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      event.thumbnailImage,
                      fit: BoxFit.cover,
                    ),
                    // You can later build the JAN/08 badge here with Positioned.
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Texts
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
