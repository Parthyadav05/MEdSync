import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

class ReviewController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Reactive variables to store image path and review text
  RxString imagePath = ''.obs;
  RxString reviewText = ''.obs;

  // Method to set the image path
  void setImage(String path) {
    imagePath.value = path;
  }

  // Method to set the review text
  void setReviewText(String text) {
    reviewText.value = text;
  }

  // Function to add a review with a photo to Firestore and Storage
  Future<void> addReviewWithPhoto() async {
    try {
      if (imagePath.isEmpty || reviewText.isEmpty) {
        Get.snackbar('Error', 'Please select an image and enter a comment');
        return;
      }

      String photoUrl = imagePath.value;
      Reference ref = _storage.ref().child('reviews_photos/${DateTime.now().millisecondsSinceEpoch}');
      UploadTask uploadTask = ref.putFile(File(photoUrl));
      TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
      String downloadURL = await snapshot.ref.getDownloadURL();

      await _firestore.collection('reviews').add({
        'review_text': reviewText.value,
        'photo_url': downloadURL,
        'timestamp': FieldValue.serverTimestamp(),
      });

      Get.snackbar('Success', 'Review added successfully');
    } catch (e) {
      print('Error adding review: $e');
      Get.snackbar('Error', 'Failed to add review');
    }
  }

  // Reactive list to store reviews data
  RxList<Map<String, dynamic>> reviewsList = <Map<String, dynamic>>[].obs;

  // Function to fetch reviews from Firestore
  Future<void> fetchReviews() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
      await _firestore.collection('reviews').get();
      if (snapshot.docs.isNotEmpty) {
        reviewsList.assignAll(snapshot.docs.map((doc) => doc.data()).toList());
      }
    } catch (e) {
      print('Error fetching reviews: $e');
    }
  }

  // Function to fetch reviews with images from Firestore and Storage
  Future<void> fetchReviewsWithImages() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
      await _firestore.collection('reviews').get();

      if (snapshot.docs.isNotEmpty) {
        List<Map<String, dynamic>> reviews = [];
        for (var doc in snapshot.docs) {
          Map<String, dynamic> reviewData = doc.data();
          if (reviewData.containsKey('photo_url')) {
            String imageURL = reviewData['photo_url'];
            reviewData['image_url'] = await _getImageURL(imageURL);
          }
          reviews.add(reviewData);
        }
        reviewsList.assignAll(reviews);
      }
    } catch (e) {
      print('Error fetching reviews: $e');
    }
  }

  // Function to fetch image URLs from Firebase Storage
  Future<String> _getImageURL(String imagePath) async {
    try {
      return await _storage.ref(imagePath).getDownloadURL();
    } catch (e) {
      print('Error fetching image: $e');
      return ''; // Return empty string or default image URL in case of error
    }
  }
}
