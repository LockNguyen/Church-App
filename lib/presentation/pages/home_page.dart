import 'package:flutter/material.dart';
import '../widgets/church_banner.dart';
import '../widgets/navigation_card.dart';

class HomePage extends StatelessWidget {
  final Function(int) onNavigate;

  const HomePage({
    super.key,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ChurchBanner(),
          SizedBox(height: 24),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Welcome to VBC-WS',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Choose an option below',
              style: TextStyle(
                fontSize: 18,
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 24),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                NavigationCard(
                  title: 'Upcoming Events',
                  icon: Icons.calendar_today,
                  accentColor: colorScheme.primary,
                  onTap: () => onNavigate(1),
                ),
                SizedBox(height: 16),
                NavigationCard(
                  title: 'Re-watch Sermon',
                  icon: Icons.play_circle_outline,
                  accentColor: colorScheme.secondary,
                  onTap: () => onNavigate(2),
                ),
                SizedBox(height: 16),
                NavigationCard(
                  title: 'Prayer Requests',
                  icon: Icons.volunteer_activism,
                  accentColor: colorScheme.tertiary,
                  onTap: () => onNavigate(3),
                ),
                SizedBox(height: 16),
                NavigationCard(
                  title: 'Giving',
                  icon: Icons.card_giftcard,
                  accentColor: colorScheme.primaryContainer,
                  onTap: () => onNavigate(4),
                ),
                SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
