import 'package:flutter/material.dart';

// Custom Bottom Navigation Bar widget used in the app
class BottomNavBar extends StatelessWidget {

  // Current selected tab index
  final int currentIndex;

  // Callback function triggered when a tab is tapped
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {

    return BottomNavigationBar(
      // Background color of navigation bar
      backgroundColor: Colors.black,

      // Color for selected item
      selectedItemColor: Colors.white,

      // Color for unselected items
      unselectedItemColor: Colors.grey,

      // Currently active index
      currentIndex: currentIndex,

      // Executes function when a tab is pressed
      onTap: onTap,

      // Navigation bar items
      items: const [

        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home"
        ),

        BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search"
        ),

        BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            label: "Upload"
        ),

        BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Notification"
        ),

        BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile"
        ),

      ],
    );
  }
}