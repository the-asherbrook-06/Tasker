import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreUnarchiveTask {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> unarchiveTask(
      String userEmail, String taskId, Map<String, dynamic> taskData) async {
    try {
      await _db
          .collection('Users')
          .doc(userEmail)
          .collection('Ongoing_Tasks')
          .doc(taskId)
          .set({'Task': taskData});

      await _db
          .collection('Users')
          .doc(userEmail)
          .collection('Archived_Tasks')
          .doc(taskId)
          .delete();

      print("Task successfully unarchived.");
    } catch (e) {
      print("Failed to unarchive task: $e");
      rethrow;
    }
  }
}
