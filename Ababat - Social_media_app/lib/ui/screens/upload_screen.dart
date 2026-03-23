import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// Screen that allows users to upload images or videos
class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {

  // ImagePicker instance used to access gallery or camera
  final ImagePicker picker = ImagePicker();

  // File variables used for mobile platforms (Android / iOS)
  File? videoFile;
  File? imageFile;

  // Uint8List variables used for Flutter Web
  Uint8List? webImage;
  Uint8List? webVideo;

  /// Function to pick a video from the gallery
  Future pickVideo() async {

    // Opens gallery and allows user to select a video
    final XFile? video = await picker.pickVideo(
      source: ImageSource.gallery,
    );

    // If no video is selected, stop execution
    if (video == null) return;

    // Web platform handling
    if (kIsWeb) {
      // Convert video to bytes for web preview
      webVideo = await video.readAsBytes();
    } else {
      // For mobile platforms, store the file path
      videoFile = File(video.path);
    }

    // Reset image preview if video is selected
    setState(() {
      imageFile = null;
      webImage = null;
    });

    // Print file path in console for debugging
    print(video.path);
  }

  /// Function to pick an image from the gallery
  Future pickImage() async {

    // Opens gallery and allows user to select an image
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    // If no image is selected, stop execution
    if (image == null) return;

    // Web platform handling
    if (kIsWeb) {
      // Convert image to bytes for preview
      webImage = await image.readAsBytes();
    } else {
      // For mobile platforms, store image file
      imageFile = File(image.path);
    }

    // Reset video preview if image is selected
    setState(() {
      videoFile = null;
      webVideo = null;
    });

    // Print file path in console for debugging
    print(image.path);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload"),
      ),

      // Main upload screen layout
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            /// Preview Area for selected media
            Container(
              height: 250,
              width: double.infinity,
              color: Colors.grey[900],

              child: Center(
                child: webImage != null
                // Display image preview for Flutter Web
                    ? Image.memory(webImage!, fit: BoxFit.cover)

                // Display image preview for mobile platforms
                    : imageFile != null
                    ? Image.file(imageFile!, fit: BoxFit.cover)

                // If a video is selected, show video icon placeholder
                    : webVideo != null || videoFile != null
                    ? const Icon(
                  Icons.videocam,
                  size: 80,
                  color: Colors.white,
                )

                // Default placeholder when no media is selected
                    : const Text(
                  "No media selected",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 30),

            /// Button to select and upload an image
            ElevatedButton(
              onPressed: pickImage,
              child: const Text("Upload Image"),
            ),

            const SizedBox(height: 10),

            /// Button to select and upload a video
            ElevatedButton(
              onPressed: pickVideo,
              child: const Text("Upload Video"),
            ),

          ],
        ),
      ),
    );
  }
}