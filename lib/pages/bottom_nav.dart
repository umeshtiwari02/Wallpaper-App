import 'package:chat_practice/pages/categories.dart';
import 'package:chat_practice/pages/home.dart';
import 'package:chat_practice/pages/search.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentTabIndex = 0;

  late List<Widget> pages;
  late HomePage home;
  late Categories categories;
  late Search search;
  late Widget currentPage;

  @override
  void initState() {
    home = HomePage();
    search = Search();
    categories = Categories();
    pages = [home, search, categories];
    currentPage = HomePage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        color: const Color.fromARGB(255, 84, 87, 93),
        animationDuration: const Duration(milliseconds: 500),
        backgroundColor: Colors.white,
        buttonBackgroundColor: Colors.black,
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
          });
        },
        items: const [
          Icon(Icons.home_outlined, color: Colors.white),
          Icon(Icons.search_outlined, color: Colors.white),
          Icon(Icons.category, color: Colors.white)
        ],
      ),
      body: pages[currentTabIndex],
    );
  }
}
