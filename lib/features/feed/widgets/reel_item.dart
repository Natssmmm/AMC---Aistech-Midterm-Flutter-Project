import 'package:flutter/material.dart';

// Widget representing a single reel/video item in the feed
class ReelItem extends StatelessWidget {
  const ReelItem({super.key});

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [

        // Background placeholder for video content
        Container(
          color: Colors.black,
        ),

        // Positioned text overlay at the bottom
        Positioned(
          bottom: 40,
          left: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
            ],
          ),
        )
      ],
    );
  }
}