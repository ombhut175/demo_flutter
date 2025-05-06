import 'package:demo_flutter/pages/tabs/profile.dart';
import 'package:demo_flutter/pages/tabs/settings.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Home extends StatefulWidget {
  final bool isCloudUser;

  const Home({super.key, this.isCloudUser = false});

  @override
  State<Home> createState() =>
      _HomeState();
}

class _HomeState
    extends State<Home>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late PageController _pageController;
  late AnimationController _animationController;
  late List<Widget> _pages = [];



  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _pages = [
      Profile(),
      Settings(),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;

    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) {
          setState(() => _selectedIndex = index);
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        height: 60,
        items: <Widget>[
          // First item: Users
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.people,
                  color: _selectedIndex == 0 ? Colors.white : Colors.grey),
              Text(
                'Profile',
                style: TextStyle(
                    color: _selectedIndex == 0 ? Colors.white : Colors.grey,
                    fontSize: 12),
              ),
            ],
          ),
          // Second item: Favorites
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.settings,
                  color: _selectedIndex == 1 ? Colors.white : Colors.grey),
              Text(
                'Settings',
                style: TextStyle(
                    color: _selectedIndex == 1 ? Colors.white : Colors.grey,
                    fontSize: 12),
              ),
            ],
          ),
        ],
        color: theme.cardColor,
        buttonBackgroundColor: primaryColor,
        backgroundColor: theme.scaffoldBackgroundColor,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        onTap: _onItemTapped,
      ),
    );
  }
}