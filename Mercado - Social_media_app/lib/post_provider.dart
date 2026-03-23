import 'package:flutter/material.dart';

class PostProvider extends ChangeNotifier {
  // This list holds the Cloudinary URLs while the app is running
  final List<String> _postUrls = [];

  List<String> get postUrls => _postUrls;

  void addPost(String url) {
    _postUrls.insert(0, url); // Put new images at the top
    notifyListeners(); // This tells the Profile screen to update
  }
}