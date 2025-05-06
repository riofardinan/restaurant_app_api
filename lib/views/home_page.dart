import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/restaurant_list.dart';
import 'package:restaurant_app/providers/restaurant_search.dart';
import 'package:restaurant_app/services/restaurant_services.dart';
import 'package:restaurant_app/views/search_page.dart';
import 'package:restaurant_app/views/theme/theme.dart';
import 'package:restaurant_app/views/restaurant_page.dart';
import 'package:restaurant_app/views/settings_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home-page';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  int _bottomNavIndex = 0;
  final List<Widget> _listWidget = [
    ChangeNotifierProvider<ListRestaurantProvider>(
      create: (_) =>
          ListRestaurantProvider(restaurantServices: RestaurantServices()),
      child: const RestaurantPage(),
    ),
    ChangeNotifierProvider<SearchRestaurantProvider>(
      create: (_) => SearchRestaurantProvider(),
      child: const SearchPage(),
    ),
    const SettingsPage(),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home_filled),
      label: 'home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: 'search',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: secondaryColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.white,
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }
}
