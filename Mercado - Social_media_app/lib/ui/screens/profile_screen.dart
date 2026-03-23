import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
// Fix this path to point to the file you created in Step 1
import '../../post_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Listen to the PostProvider for the list of URLs
    final posts = Provider.of<PostProvider>(context).postUrls;

    return Scaffold(
      appBar: AppBar(title: const Text("My Profile")),
      body: posts.isEmpty
          ? const Center(child: Text("No posts yet. Upload something!"))
          : GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3 images per row like Instagram
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return CachedNetworkImage(
            imageUrl: posts[index],
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(color: Colors.grey[300]),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          );
        },
      ),
    );
  }
}