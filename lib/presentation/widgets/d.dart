import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomePageAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AppBar(
      backgroundColor: colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      title: Row(
        mainAxisSize: MainAxisSize.min, // Prevents Row from taking full width
        children: [
          // Smaller circle logo
          Container(
            width: 32,  // Reduced from 40
            height: 32, // Reduced from 40
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
                  fontSize: 16, // Reduced from 20
                ),
              ),
            ),
          ),
          SizedBox(width: 8), // Reduced from 12
          Text(
            'VBC-WS',
            style: TextStyle(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w600,
              fontSize: 18, // Explicit size for consistency
            ),
          ),
        ],
      ),
      actions: [
        _buildIconButton(
          context,
          'assets/icons/icon1.svg',
          'Menu',
          () => _openModalPage(context, 'Menu', colorScheme.primaryContainer),
        ),
        _buildIconButton(
          context,
          'assets/icons/icon2.svg',
          'Settings',
          () => _openModalPage(context, 'Settings', colorScheme.secondaryContainer),
        ),
        _buildIconButton(
          context,
          'assets/icons/icon3.svg',
          'Notifications',
          () => _openModalPage(context, 'Notifications', colorScheme.tertiaryContainer),
        ),
        _buildIconButton(
          context,
          'assets/icons/icon4.svg',
          'Profile',
          () => _openModalPage(context, 'Profile', colorScheme.surfaceContainerHighest),
        ),
        SizedBox(width: 4), // Reduced from 8
      ],
    );
  }

  Widget _buildIconButton(
    BuildContext context,
    String assetPath,
    String label,
    VoidCallback onTap,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return IconButton(
      icon: SvgPicture.asset(
        assetPath,
        width: 22, // Slightly reduced from 24
        height: 22,
        colorFilter: ColorFilter.mode(
          colorScheme.onSurface,
          BlendMode.srcIn,
        ),
      ),
      onPressed: onTap,
      tooltip: label,
      padding: EdgeInsets.all(8), // Tighter padding
      constraints: BoxConstraints(), // Remove default constraints
    );
  }

  void _openModalPage(BuildContext context, String title, Color backgroundColor) {
    final colorScheme = Theme.of(context).colorScheme;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: backgroundColor,
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
          body: Container(
            width: double.infinity,
            color: backgroundColor,
            child: Center(
              child: Text(
                'Content coming soon',
                style: TextStyle(
                  fontSize: 18,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
