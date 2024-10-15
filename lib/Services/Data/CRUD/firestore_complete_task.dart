import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreCompleteTask {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> completeTask(
      String userEmail, String taskId, Map<String, dynamic> taskData) async {
    try {
      await _db
          .collection('Users')
          .doc(userEmail)
          .collection('Completed_Tasks')
          .doc(taskId)
          .set({'Task': taskData});

      await _db
          .collection('Users')
          .doc(userEmail)
          .collection('Ongoing_Tasks')
          .doc(taskId)
          .delete();

      print("Task successfully marked as completed.");
    } catch (e) {
      print("Failed to complete task: $e");
      rethrow;
    }
  }
}
