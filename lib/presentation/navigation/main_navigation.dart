import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../pages/events_page.dart';
import '../pages/sermon_page.dart';
import '../pages/prayer_page.dart';
import '../pages/giving_page.dart';
import '../widgets/home_page_app_bar.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(onNavigate: _onNavigate),
      EventsPage(),
      SermonPage(),
      PrayerPage(),
      GivingPage(),
    ];
  }

  void _onNavigate(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex == 0 ? HomePageAppBar() : null,
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavigate,
      ),
    );
  }
}