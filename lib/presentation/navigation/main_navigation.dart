import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../pages/events_page.dart';
import '../pages/sermon_page.dart';
import '../pages/prayer_page.dart';
import '../pages/giving_page.dart';
import '../widgets/custom_bottom_nav_bar.dart';

/// Main navigation controller that manages page transitions with animations.
/// 
/// This widget handles navigation between five pages (Home, Events, Sermon,
/// Prayer, Giving) with slide-in transitions while keeping the bottom
/// navigation bar stationary.
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  // Tracks which page is currently displayed (0 = Home, 1 = Events, etc.).
  int _previousIndex = -1;
  int _currentIndex = 0;

  // Holds all five pages. Declared as 'late' because it depends on methods
  // not available until initState runs.
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    
    // Initialize all pages once. HomePage receives a callback to trigger
    // navigation when cards are tapped.
    _pages = [
      HomePage(onNavigate: _onNavigate),
      EventsPage(),
      SermonPage(),
      PrayerPage(),
      GivingPage(),
    ];
  }

  /// Handles navigation requests from child widgets.
  /// 
  /// When called, updates the current page index and triggers a rebuild
  /// with animation via setState.
  void _onNavigate(int index) {
    setState(() {
      _previousIndex = _currentIndex;
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        
        transitionBuilder: (Widget child, Animation<double> animation) {
          // Extract the key from the child to determine if it's current or old.
          final widget = child as KeyedSubtree;
          final widgetKey = widget.key as ValueKey<int>;
          final isIncoming = widgetKey.value == _currentIndex;
          final isGoingRight = _previousIndex < _currentIndex;
          
          // Incoming: slide from right (1.0, 0.0) to center (0.0, 0.0)
          // Outgoing: slide from center (0.0, 0.0) to left (-1.0, 0.0)
          final offsetAnimation = Tween<Offset>(
            begin: isGoingRight
              ? (isIncoming ? Offset(1.0, 0.0) : Offset(-1.0, 0.0))
              : (isIncoming ? Offset(-1.0, 0.0) : Offset(1.0, 0.0)),
            end: Offset.zero, // end animation is reverse, so page slides in at 0 and also out at 0
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          ));

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        
        // Stack both widgets during transition so they're visible simultaneously.
        layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
          return Stack(
            alignment: Alignment.center,
            children: [
              ...previousChildren, // Old page(s) underneath
              if (currentChild != null) currentChild, // New page on top
            ],
          );
        },
        
        child: KeyedSubtree(
          key: ValueKey<int>(_currentIndex),
          child: _pages[_currentIndex],
        ),
      ),

      
      // Bottom nav bar stays outside AnimatedSwitcher so it never animates.
      // It remains stationary with built-in Material 3 tap animations intact.
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex, // Highlight correct icon.
        onTap: _onNavigate,          // Handle navigation taps.
      ),
    );
  }
}
