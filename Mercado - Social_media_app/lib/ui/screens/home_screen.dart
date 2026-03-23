import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:photo_view/photo_view.dart';
import '../../core/widgets/bottom_nav_bar.dart';
import '../../features/feed/screens/feed_screen.dart';
import 'search_screen.dart';
import 'upload_screen.dart';
import 'notification_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  final screens = [
    const FeedScreen(),
    const SearchScreen(),
    const UploadScreen(),
    const NotificationScreen(),
    const ProfileScreen()
  ];

  // 1. UPDATED WITH 3 NEW RANDOM PICTURES
  final List<String> images = [
    'https://images.unsplash.com/photo-1502673530728-f79b4cab31b1?q=80&w=1000&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1469474968028-56623f02e42e?q=80&w=1000&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1501785888041-af3ef285b470?q=80&w=1000&auto=format&fit=crop',
  ];

  // 2. STATE FIX: Tracks image index per vertical post
  // to prevent one post's swipe affecting others.
  final Map<int, int> _postImageIndices = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: index == 0
          ? PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 10,
        itemBuilder: (context, postIndex) {
          // Get the current image index for this specific post
          int currentImg = _postImageIndices[postIndex] ?? 0;

          return Stack(
            fit: StackFit.expand,
            children: [
              /// Horizontal Image Swipe
              PageView.builder(
                itemCount: images.length,
                onPageChanged: (i) {
                  setState(() {
                    _postImageIndices[postIndex] = i;
                  });
                },
                itemBuilder: (context, i) {
                  return GestureDetector(
                    onTap: () => openImageViewer(i),
                    child: Image.network(
                      images[i],
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(
                          child: CircularProgressIndicator(
                              color: Colors.white24),
                        );
                      },
                    ),
                  );
                },
              ),

              /// Right Buttons
              Positioned(
                right: 15,
                bottom: 100,
                child: Column(
                  children: [
                    _buildProfileIcon(),
                    const TikTokButton(
                        icon: Icons.favorite,
                        label: '1.2M',
                        color: Colors.red),
                    const TikTokButton(
                        icon: Icons.comment_rounded, label: '850'),
                    const TikTokButton(
                        icon: Icons.bookmark, label: '45K'),
                    const TikTokButton(
                        icon: Icons.reply_rounded, label: 'Share'),
                    const SizedBox(height: 10),
                    _buildMusicDisc(),
                  ],
                ),
              ),

              /// Caption
              Positioned(
                left: 15,
                bottom: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '@flutter_developer',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    const SizedBox(
                      width: 250,
                      child: Text(
                        'Exploring nature with Flutter! 🌲 #nature #flutter',
                        style: TextStyle(
                            color: Colors.white, fontSize: 14),
                        maxLines: 2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: const [
                        Icon(Icons.music_note,
                            color: Colors.white, size: 15),
                        SizedBox(width: 5),
                        Text(
                          'Original Sound - Travel',
                          style: TextStyle(
                              color: Colors.white, fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              /// Image Counter
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
                    style: const TextStyle(
                        color: Colors.white, fontSize: 12),
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

  void openImageViewer(int index) {
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
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 1.5),
              color: Colors.grey[800],
            ),
            child: ClipOval(
              child: Image.network(
                'https://picsum.photos/200',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: -8,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                color: Color(0xFFFE2C55),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMusicDisc() {
    return Container(
      width: 50,
      height: 50,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const RadialGradient(colors: [Colors.black54, Colors.black]),
        border: Border.all(color: Colors.grey[800]!, width: 10),
      ),
      child: const Icon(Icons.music_note, color: Colors.white, size: 20),
    );
  }
}

class TikTokButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const TikTokButton({
    super.key,
    required this.icon,
    required this.label,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Icon(icon, size: 35, color: color),
          const SizedBox(height: 4),
          Text(label,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

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
              return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(images[index]),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
              );
            },
            scrollPhysics: const BouncingScrollPhysics(),
            backgroundDecoration: const BoxDecoration(color: Colors.black),
          ),
          // FIXED: Corrected syntax for line 294 and 295
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