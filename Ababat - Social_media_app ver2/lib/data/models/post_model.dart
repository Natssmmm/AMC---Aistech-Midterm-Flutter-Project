// Data model representing a social media post
class PostModel {

  // Unique ID of the post
  final String id;

  // ID of the user who created the post
  final String userId;

  // URL of the uploaded media (image or video)
  final String mediaUrl;

  // Caption text for the post
  final String caption;

  // Number of likes the post received
  final int likes;

  // Constructor for creating PostModel objects
  PostModel({
    required this.id,
    required this.userId,
    required this.mediaUrl,
    required this.caption,
    required this.likes
  });

}