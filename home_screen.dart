import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import '../../core/widgets/bottom_nav_bar.dart';
import '../../features/feed/screens/feed_screen.dart';
import 'search_screen.dart';
import 'upload_screen.dart';
import 'notification_screen.dart';
import 'profile_screen.dart';
import '../../features/auth/providers/auth_provider.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  int index = 0;

  @override
  bool get wantKeepAlive => true;

  final screens = [
    const FeedScreen(),
    const SearchScreen(),
    const UploadScreen(),
    const NotificationScreen(),
    const ProfileScreen()
  ];

  final Map<int, int> _postImageIndices = {};
  final Map<int, bool> _likedPosts = {};
  final Map<int, bool> _bookmarkedPosts = {};

  /// 🔥 Generate 3 unique random images per post
  List<String> getImagesForPost(int postIndex) {
    final random = Random(postIndex); // seed for consistent images per post
    return List.generate(3, (_) {
      return 'https://picsum.photos/800/1200?random=${random.nextInt(1000)}';
    });
  }

  void _showComments(BuildContext context, int postIndex) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        height: 400,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text("Comments",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, i) => ListTile(
                  leading: const CircleAvatar(backgroundColor: Colors.grey),
                  title: Text("User $i"),
                  subtitle: const Text("Nice shot! 🔥"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: index == 0
          ? PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 10,
        itemBuilder: (context, postIndex) {
          final images = getImagesForPost(postIndex);
          int currentImg = _postImageIndices[postIndex] ?? 0;
          bool isLiked = _likedPosts[postIndex] ?? false;
          bool isBookmarked = _bookmarkedPosts[postIndex] ?? false;

          return Stack(
            fit: StackFit.expand,
            children: [
              /// IMAGE SLIDER
              PageView.builder(
                itemCount: images.length,
                onPageChanged: (i) {
                  setState(() {
                    _postImageIndices[postIndex] = i;
                  });
                },
                itemBuilder: (context, i) {
                  return GestureDetector(
                    onTap: () => openImageViewer(images, i),
                    child: Image.network(
                      images[i],
                      fit: BoxFit.cover,
                      loadingBuilder:
                          (context, child, progress) {
                        if (progress == null) return child;
                        return const Center(
                          child: CircularProgressIndicator(
                              color: Colors.white),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(Icons.broken_image,
                              color: Colors.white, size: 40),
                        );
                      },
                    ),
                  );
                },
              ),

              /// RIGHT BUTTONS
              Positioned(
                right: 15,
                bottom: 100,
                child: Column(
                  children: [
                    _buildProfileIcon(),
                    TikTokButton(
                      icon: Icons.favorite,
                      label: '1.2M',
                      color: isLiked ? Colors.red : Colors.white,
                      onTap: () {
                        setState(() {
                          _likedPosts[postIndex] = !isLiked;
                        });
                      },
                    ),
                    TikTokButton(
                      icon: Icons.comment,
                      label: '850',
                      onTap: () =>
                          _showComments(context, postIndex),
                    ),
                    TikTokButton(
                      icon: Icons.bookmark,
                      label: '45K',
                      color:
                      isBookmarked ? Colors.amber : Colors.white,
                      onTap: () {
                        setState(() {
                          _bookmarkedPosts[postIndex] =
                          !isBookmarked;
                        });
                      },
                    ),
                    TikTokButton(
                      icon: Icons.reply,
                      label: 'Share',
                    ),
                    const SizedBox(height: 10),
                    _buildMusicDisc(),
                  ],
                ),
              ),

              /// CAPTION
              Positioned(
                left: 15,
                bottom: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('@flutter_dev',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    SizedBox(
                      width: 250,
                      child: Text(
                        'Exploring nature 🌲 #flutter',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),

              /// IMAGE COUNT
              Positioned(
                right: 15,
                top: 60,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${currentImg + 1}/${images.length}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          );
        },
      )
          : screens[index],
      bottomNavigationBar: BottomNavBar(
        currentIndex: index,
        onTap: (i) => setState(() => index = i),
      ),
    );
  }

  /// Pass images per post to the viewer
  void openImageViewer(List<String> images, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ImageViewer(
          images: images,
          initialIndex: index,
        ),
      ),
    );
  }

  Widget _buildProfileIcon() {
    return GestureDetector(
      onTap: () {
        context.read<AuthProvider>().logout();
      },
      child: const CircleAvatar(radius: 25),
    );
  }

  Widget _buildMusicDisc() {
    return const Icon(Icons.music_note, color: Colors.white);
  }
}

class TikTokButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback? onTap;

  const TikTokButton({
    super.key,
    required this.icon,
    required this.label,
    this.color = Colors.white,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, size: 30, color: color),
          Text(label, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}

/// IMAGE VIEWER
class ImageViewer extends StatelessWidget {
  final List<String> images;
  final int initialIndex;

  const ImageViewer({
    super.key,
    required this.images,
    required this.initialIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            itemCount: images.length,
            pageController: PageController(initialPage: initialIndex),
            builder: (context, index) {
              return PhotoViewGalleryPageOptions.customChild(
                child: Image.network(
                  images[index],
                  fit: BoxFit.contain,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return const Center(
                        child: CircularProgressIndicator(
                            color: Colors.white));
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                        child: Icon(Icons.broken_image,
                            color: Colors.white, size: 40));
                  },
                ),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
              );
            },
            backgroundDecoration: const BoxDecoration(color: Colors.black),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}