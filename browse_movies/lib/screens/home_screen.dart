import 'package:browse_movies/components/bottom_nav_bar.dart';
import 'package:browse_movies/components/demo_home_screen.dart';
import 'package:browse_movies/services/profile_screen.dart';
import 'package:browse_movies/util/favourite_screen.dart';
import 'package:browse_movies/util/search_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool _isSearching = false;

  void _openSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  void _closeSearch() {
    setState(() {
      _isSearching = false;
    });
  }

  void _onSearchChanged(String query) {
    // handle live search logic here
    print("Search query: $query");
  }

  void navigateBottomBar(int index) {
    if (index == 1) {
      _openSearch(); // Show the search overlay
    } else {
      setState(() {
        _isSearching = false;
        _selectedIndex = index;
      });
    }
  }

  final List<Widget> _screens = [
    MainHomeScreen(),
    Container(), // Placeholder for search, won't be shown directly
    const FavouriteScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      bottomNavigationBar: _isSearching
          ? null
          : MyBottomNavBar(onTabChange: navigateBottomBar),
      body: Stack(
        children: [
          _screens[_selectedIndex],
          if (_isSearching)
            SearchScreen(
              onClose: _closeSearch,
              onSearchChanged: _onSearchChanged,
            ),
        ],
      ),
    );
  }
}
