import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> addCloth(String userId, String category, String name, File image) async {
    // Upload image to Firebase Storage
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = _storage.ref().child('clothes_images/$fileName');
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    String imageUrl = await taskSnapshot.ref.getDownloadURL();

    // Add cloth document to Firestore
    await _firestore.collection('users').doc(userId).collection('clothes').add({
      'category': category,
      'name': name,
      'imageUrl': imageUrl,
      'status': 'In Closet',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<List<Map<String, dynamic>>> getClothes(String userId, {String? category}) async {
    QuerySnapshot querySnapshot;
    if (category != null) {
      querySnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('clothes')
          .where('category', isEqualTo: category)
          .get();
    } else {
      querySnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('clothes')
          .get();
    }

    return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  Future<void> updateClothStatus(String userId, String clothId, String newStatus) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('clothes')
        .doc(clothId)
        .update({'status': newStatus});
  }

  Future<void> deleteCloth(String userId, String clothId) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('clothes')
        .doc(clothId)
        .delete();
  }

  Future<void> addLaundryHistory(String userId, String clothId, String action) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('laundry_history')
        .add({
      'clothId': clothId,
      'action': action,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<List<Map<String, dynamic>>> getLaundryHistory(String userId, String clothId) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('laundry_history')
        .where('clothId', isEqualTo: clothId)
        .orderBy('timestamp', descending: true)
        .get();

    return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }
}