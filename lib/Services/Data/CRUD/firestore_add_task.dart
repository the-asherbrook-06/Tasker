import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreAddTask {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addTask(
      String userEmail, String taskType, Map<String, dynamic> taskData) async {
    try {
      DocumentReference newTaskRef =
          _db.collection('Users').doc(userEmail).collection(taskType).doc();

      taskData['TaskId'] = newTaskRef.id;
      taskData['CreatedAt'] = FieldValue.serverTimestamp();

      await newTaskRef.set({'Task': taskData});

      print("Task successfully added to Firestore with ID: ${newTaskRef.id}");
    } catch (e) {
      print("Failed to add task: $e");
      rethrow;
    }
  }
}
