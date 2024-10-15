import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreRestoreTask {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> restoreTask(
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
          .collection('Deleted_Tasks')
          .doc(taskId)
          .delete();

      print("Task successfully restored from deleted.");
    } catch (e) {
      print("Failed to restore task: $e");
      rethrow;
    }
  }
}
