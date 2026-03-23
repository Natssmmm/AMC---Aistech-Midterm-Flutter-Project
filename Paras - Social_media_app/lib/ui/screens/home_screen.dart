import 'package:flutter/material.dart';
import '../../core/widgets/bottom_nav_bar.dart';
import '../../features/feed/screens/feed_screen.dart';
import 'search_screen.dart';
import 'upload_screen.dart';
import 'notification_screen.dart';
import 'profile_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

// Main screen that controls navigation between tabs
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // Currently selected tab index
  int index = 0;

  // List of screens corresponding to navigation tabs
  final screens = [
    const FeedScreen(),
    const SearchScreen(),
    const UploadScreen(),
    const NotificationScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // Displays the selected screen
      body: screens[index],

      // Bottom navigation bar
      bottomNavigationBar: BottomNavBar(
        currentIndex: index,

        // Updates selected tab
        onTap: (i){
          setState(() {
            index = i;
          });
        },
      ),
    );
  }
}