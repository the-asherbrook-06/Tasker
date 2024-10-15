import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreUpdateTask {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> updateTask(String userEmail, String taskType, String taskId,
      Map<String, dynamic> updatedData) async {
    try {
      await _db
          .collection('Users')
          .doc(userEmail)
          .collection(taskType)
          .doc(taskId)
          .update({'Task': updatedData});

      print("Task successfully updated.");
    } catch (e) {
      print("Failed to update task: $e");
      rethrow;
    }
  }
}
