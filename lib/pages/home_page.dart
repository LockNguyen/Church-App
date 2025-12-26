import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomePageAppBar(),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: .center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              'n/a',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class HomePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomePageAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.onSurface,
      elevation: 0,
      title: Row(
        children: [
          // Circle logo on the left
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Center(
              child: Text(
                'V',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          // VBC-WS text
          Text(
            'VBC-WS',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      actions: [
        // AppBar clickable SVG icons
        _buildIconButton(
          context,
          'icons/placeholder.svg',
          'Settings',
          () => _openModalPage(context, 'Messages', Colors.green.shade50),
        ),
        _buildIconButton(
          context,
          'icons/placeholder.svg',
          'Notifications',
          () => _openModalPage(context, 'Search', Colors.orange.shade50),
        ),
        _buildIconButton(
          context,
          'icons/placeholder.svg',
          'Profile',
          () => _openModalPage(context, 'Profile', Colors.purple.shade50),
        ),
        SizedBox(width: 8),
      ],
    );
  }
}

// Helper method for icon buttons
Widget _buildIconButton(
  BuildContext context,
  String assetPath,
  String label,
  VoidCallback onTap,
) {
  return IconButton(
    icon: SvgPicture.asset(
      assetPath,
      width: 24,
      height: 24,
      colorFilter: ColorFilter.mode(
        Colors.black87,
        BlendMode.srcIn,
      ),
    ),
    onPressed: onTap,
    tooltip: label,
  );
}

// Method to open modal bottom sheet with slide-up animation
void _openModalPage(BuildContext context, String title, Color backgroundColor) {
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
            icon: Icon(Icons.arrow_back, color: Colors.black87),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            title,
            style: TextStyle(color: Colors.black87),
          ),
        ),
        body: Container(
          width: double.infinity,
          color: backgroundColor,
          // Add your page content here
        ),
      ),
    ),
  );
}