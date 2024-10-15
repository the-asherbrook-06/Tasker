import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreTasks {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchAllTasks(
      String userEmail, String collectionName) async {
    try {
      print("Fetching all tasks for user: $userEmail from $collectionName");
      final querySnapshot = await _db
          .collection('Users')
          .doc(userEmail)
          .collection(collectionName)
          .get();

      print("Documents fetched: ${querySnapshot.docs.length}");
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print("Error fetching tasks: $e");
      return [];
    }
  }
}
