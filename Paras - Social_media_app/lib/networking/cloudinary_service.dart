import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';

class CloudinaryService {
  // Replace these with the information you found in Step 1
  static const String _cloudName = "";
  static const String _uploadPreset = "";

  static final CloudinaryPublic _cloudinary = CloudinaryPublic(
    _cloudName,
    _uploadPreset,
    cache: false,
  );

  static Future<String?> uploadImage(XFile file) async {
    try {
      // We use readAsBytes so it works on Web and Mobile
      final bytes = await file.readAsBytes();

      CloudinaryResponse response = await _cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          Bytes,
          identifier: file.name,
          resourceType: CloudinaryResourceType.Image,
        ),
      );

      return response.secureUrl; // This is the URL we save to Provider
    } catch (e) {
      debugPrint("Cloudinary Upload Error: $e");
      return null;
    }
  }
}