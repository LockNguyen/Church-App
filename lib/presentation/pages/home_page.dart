import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../l10n/generated/app_localizations.dart';
import '../widgets/home_page/church_banner.dart';
import '../widgets/home_page/navigation_card.dart';

class HomePage extends StatelessWidget {
  final Function(int) onNavigate;

  const HomePage({
    super.key,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Container(
      color: colorScheme.surface, // This is the Scaffold's default background.
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildAppBar(context),
            ChurchBanner(),
            SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  NavigationCard(
                    title: l10n.pageEventsTitle,
                    image: 'assets/images/calendar.jpg',
                    accentColor: colorScheme.primary,
                    onTap: () => onNavigate(1),
                  ),
                  SizedBox(height: 24),
                  NavigationCard(
                    title: l10n.pageDiscipleshipTitle,
                    image: 'assets/images/preaching.jpg',
                    accentColor: colorScheme.secondary,
                    onTap: () => onNavigate(2),
                  ),
                  SizedBox(height: 24),
                  NavigationCard(
                    title: l10n.pagePrayerTitle,
                    image: 'assets/images/praying.jpg',
                    accentColor: colorScheme.tertiary,
                    onTap: () => onNavigate(3),
                  ),
                  SizedBox(height: 24),
                  NavigationCard(
                    title: l10n.pageGivingTitle,
                    image: 'assets/images/giving.jpg',
                    accentColor: colorScheme.primaryContainer,
                    onTap: () => onNavigate(4),
                  ),
                  SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Responsive AppBar that adapts to screen size.
  Widget _buildAppBar(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: kToolbarHeight,
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outlineVariant,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 8),
          // Circle logo
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.primary,
            ),
            child: Center(
              child: Text(
                'V',
                style: TextStyle(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          // App name - flexible to shrink if needed
          Flexible(
            child: Text(
            'VBC-WS',
            style: TextStyle(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w600,
              fontSize: 20,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Spacer(),
          // Responsive icon display
          if (screenWidth >= 600)
            // Desktop: Show all 4 icons
            ..._buildAllIconButtons(context)
          else if (screenWidth >= 400)
            // Tablet: Show 2 icons + menu
            ...[
              _buildIconButton(
                context,
                'assets/icons/placeholder.svg',
                'Notifications',
              ),
              _buildIconButton(
                context,
                'assets/icons/placeholder.svg',
                'Profile',
              ),
              _buildMoreMenu(context),
            ]
          else
            // Mobile: Show only menu button
            _buildMoreMenu(context),
        ],
      ),
    );
  }

  /// Build all four icon buttons (for wide screens).
  List<Widget> _buildAllIconButtons(BuildContext context) {
    return [
      _buildIconButton(context, 'assets/icons/placeholder.svg', 'Menu'),
      _buildIconButton(context, 'assets/icons/placeholder.svg', 'Settings'),
      _buildIconButton(context, 'assets/icons/placeholder.svg', 'Notifications'),
      _buildIconButton(context, 'assets/icons/placeholder.svg', 'Profile'),
    ];
  }

  /// Build a single icon button.
  Widget _buildIconButton(BuildContext context, String assetPath, String label) {
    final colorScheme = Theme.of(context).colorScheme;

    return IconButton(
      icon: SvgPicture.asset(
        assetPath,
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(
          colorScheme.onSurface,
          BlendMode.srcIn,
        ),
      ),
      onPressed: () => _openModalPage(context, label),
      tooltip: label,
    );
  }

  /// Build overflow menu for small screens.
  Widget _buildMoreMenu(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return PopupMenuButton<String>(
      icon: Icon(
        Icons.more_vert,
        color: colorScheme.onSurface,
      ),
      onSelected: (value) => _openModalPage(context, value),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'Menu',
          child: Row(
            children: [
              Icon(Icons.menu, color: colorScheme.onSurface),
              SizedBox(width: 12),
              Text('Menu'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'Settings',
          child: Row(
            children: [
              Icon(Icons.settings, color: colorScheme.onSurface),
              SizedBox(width: 12),
              Text('Settings'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'Notifications',
          child: Row(
            children: [
              Icon(Icons.notifications, color: colorScheme.onSurface),
              SizedBox(width: 12),
              Text('Notifications'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'Profile',
          child: Row(
            children: [
              Icon(Icons.person, color: colorScheme.onSurface),
              SizedBox(width: 12),
              Text('Profile'),
            ],
          ),
        ),
      ],
    );
  }

  void _openModalPage(BuildContext context, String title) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: colorScheme.primaryContainer,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              title,
              style: TextStyle(color: colorScheme.onSurface),
            ),
          ),
          body: Center(
            child: Text(
              l10n.contentComingSoon,
              style: TextStyle(
                fontSize: 18,
                color: colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
