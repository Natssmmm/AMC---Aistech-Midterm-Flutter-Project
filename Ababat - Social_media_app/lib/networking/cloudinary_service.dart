import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:image_picker/image_picker.dart';

// Service class responsible for uploading media to Cloudinary
class CloudinaryUploader {

  // Cloudinary cloud name
  static const String cloudName = "";

  // Upload preset configured in Cloudinary dashboard
  static const String uploadPreset = "";

  // Cloudinary instance
  static final CloudinaryPublic cloudinary = CloudinaryPublic(
    cloudName,
    uploadPreset,
    cache: false,
  );

  // Function to upload a file and return its URL
  static Future<String?> uploadFile(XFile file) async {
    try {

      // Upload file to Cloudinary
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          file.path,
          resourceType: CloudinaryResourceType.Auto,
        ),
      );

      // Return the secure URL of the uploaded media
      return response.secureUrl;

    } catch (e) {
      // Print error if upload fails
      print("Upload Error: $e");
      return null;
    }
  }
}