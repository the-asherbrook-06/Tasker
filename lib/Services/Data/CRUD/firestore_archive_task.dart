import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreArchiveTask {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> archiveTask(
      String userEmail, String taskId, Map<String, dynamic> taskData) async {
    try {
      await _db
          .collection('Users')
          .doc(userEmail)
          .collection('Archived_Tasks')
          .doc(taskId)
          .set({'Task': taskData});

      await _db
          .collection('Users')
          .doc(userEmail)
          .collection('Ongoing_Tasks')
          .doc(taskId)
          .delete();

      print("Task successfully archived.");
    } catch (e) {
      print("Failed to archive task: $e");
      rethrow;
    }
  }
}
