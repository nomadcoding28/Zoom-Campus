import 'package:flutter/material.dart';
import 'package:zoomcampus/home/home_page.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

final List nav = [
  HomePage(),
];

class _BottomNavigationState extends State<BottomNavigation> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: nav[index],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          type: BottomNavigationBarType.shifting,
          currentIndex: index,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
          showSelectedLabels: false,
          enableFeedback: true,
          showUnselectedLabels: false,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              backgroundColor: Colors.black,
              activeIcon: Icon(
                Icons.home,
                color: Colors.green,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              activeIcon: Icon(
                Icons.search,
                color: Colors.green,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.more_horiz,
                color: Colors.white,
              ),
              activeIcon: Icon(
                Icons.more_horiz,
                color: Colors.green,
              ),
              label: '',
            ),
          ]),
    );
  }
}
