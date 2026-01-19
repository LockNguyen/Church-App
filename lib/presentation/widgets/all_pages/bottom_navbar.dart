import 'package:flutter/material.dart';
import '../../../l10n/generated/app_localizations.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: colorScheme.surface,
      selectedItemColor: colorScheme.primary,
      unselectedItemColor: colorScheme.onSurfaceVariant,
      selectedFontSize: 14,
      unselectedFontSize: 12,
      iconSize: 28,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: l10n.navHome,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: l10n.navEvents,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.grass),
          label: l10n.navDiscipleship,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.volunteer_activism),
          label: l10n.navPrayer,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.card_giftcard),
          label: l10n.navGiving,
        ),
      ],
    );
  }
}