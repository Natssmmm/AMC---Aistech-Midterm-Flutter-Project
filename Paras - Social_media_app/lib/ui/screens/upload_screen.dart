import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:provider/provider.dart';
import '../../post_provider.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  XFile? _pickedFile;
  Uint8List? _webImage;
  bool _isUploading = false;
  final ImagePicker _picker = ImagePicker();

  Future<void> _selectImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        final Uint8List bytes = await image.readAsBytes();
        setState(() {
          _webImage = bytes;
          _pickedFile = image;
        });
      }
    } catch (e) {
      debugPrint("Error selecting image: $e");
    }
  }

  Future<void> _upload() async {
    if (_pickedFile == null || _webImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select an image first")),
      );
      return;
    }

    setState(() => _isUploading = true);

    try {
      // Configuration
      final cloudinary = CloudinaryPublic(
        'dmit6xi5o',
        'social_app',
        cache: false,
      );

      // FIX: Use .path even on Web. The cloudinary_public package
      // handles XFile paths correctly on both Web and Mobile.
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          _pickedFile!.path, // Use the path, NOT the bytes here
          identifier: _pickedFile!.name,
          resourceType: CloudinaryResourceType.Image,
        ),
      );

      if (mounted) {
        // SUCCESS: Save the URL to your PostProvider
        Provider.of<PostProvider>(context, listen: false).addPost(response.secureUrl);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Upload Successful!")),
        );

        setState(() {
          _pickedFile = null;
          _webImage = null;
        });
      }
    } catch (e) {
      debugPrint("Upload Error: $e");
      // 401 Error usually means your 'social_app' preset is NOT "Unsigned" in Cloudinary
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create New Post")),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Container(
                width: 320,
                height: 320,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: _webImage != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.memory(_webImage!, fit: BoxFit.cover),
                )
                    : const Icon(Icons.add_a_photo, size: 60, color: Colors.grey),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: _selectImage,
                icon: const Icon(Icons.photo_library),
                label: const Text("Select from Gallery"),
              ),
              const SizedBox(height: 15),
              if (_pickedFile != null)
                _isUploading
                    ? const CircularProgressIndicator()
                    : ElevatedButton.icon(
                  onPressed: _upload,
                  icon: const Icon(Icons.cloud_upload),
                  label: const Text("Upload Now"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}