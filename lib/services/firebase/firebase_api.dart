// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseAPI {
  FirebaseApp? app;
  FirebaseFirestore? firestore;
  static final DatabaseAPI instance = DatabaseAPI();

  Future<void> initialize() async {
    app = await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyC5GgZIR5HowxBAs6AeH6moNxB4KJKBQPo",
        appId: "1:873884230087:web:c51c523f611b3c6ec8b9e2",
        messagingSenderId: "873884230087",
        projectId: "scouting-25",
        storageBucket: "scouting-25.firebasestorage.app",
      ),
    );

    firestore = FirebaseFirestore.instanceFor(app: app!);
  }

  Future<void> uploadJson(Map<String, dynamic> jsonData, String collectionPath,
      String documentId) async {
    if (firestore == null) {
      throw Exception("Firebase not initialized");
    }

    try {
      await firestore!.collection(collectionPath).doc(documentId).set(jsonData);
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  Future<(Map<String, dynamic>, bool)> downloadJson(
      String collectionPath, String documentId) async {
    if (firestore == null) {
      throw Exception("Firebase not initialized");
    }

    try {
      DocumentSnapshot docSnapshot =
          await firestore!.collection(collectionPath).doc(documentId).get();
      if (docSnapshot.exists) {
        return (docSnapshot.data() as Map<String, dynamic>, true);
      } else {
        Map<String, dynamic> map = {};
        return (map, false);
      }
    } on FirebaseException catch (_) {
      rethrow;
    }
  }
}
