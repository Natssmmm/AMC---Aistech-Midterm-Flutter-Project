import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';

class CloudinaryService {
  static const String _cloudName = "";
  static const String _uploadPreset = "";

  static final CloudinaryPublic _cloudinary = CloudinaryPublic(
    _cloudName,
    _uploadPreset,
    cache: false,
  );

  static Future<String?> uploadImage(XFile file) async {
    try {
      // 1. Get the bytes as Uint8List
      final bytes = await file.readAsBytes();

      // 2. The package expects ByteData, so we convert the buffer
      final byteData = bytes.buffer.asByteData();

      // 3. Use CloudinaryFile.fromByteData instead of fromBytes
      CloudinaryResponse response = await _cloudinary.uploadFile(
        CloudinaryFile.fromByteData(
          byteData,
          identifier: file.name,
          resourceType: CloudinaryResourceType.Image,
        ),
      );

      return response.secureUrl;
    } catch (e) {
      debugPrint("Cloudinary Upload Error: $e");
      return null;
    }
  }
}