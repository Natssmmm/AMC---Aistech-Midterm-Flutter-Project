import 'package:flutter/material.dart';
import '../widgets/reel_item.dart';

// Screen that displays TikTok-style vertical scrolling feed
class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return PageView.builder(
      // Enables vertical scrolling like TikTok reels
      scrollDirection: Axis.vertical,

      // Builds reel items dynamically
      itemBuilder: (context,index){
        return const ReelItem();
      },
    );
  }
}