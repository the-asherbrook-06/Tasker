import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDeleteTask {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> deleteOngoingTask(
      String userEmail, String taskId, Map<String, dynamic> task) async {
    try {
      await _firestore
          .collection('Users')
          .doc(userEmail.toLowerCase())
          .collection('Ongoing_Tasks')
          .doc(taskId)
          .delete();

      await _firestore
          .collection('Users')
          .doc(userEmail.toLowerCase())
          .collection('Deleted_Tasks')
          .doc(taskId)
          .set(task);

      print('Successfully deleted ongoing task and moved to Deleted_Tasks.');
    } catch (error) {
      print('Error deleting ongoing task: $error');
    }
  }

  Future<void> deleteArchivedTask(
      String userEmail, String taskId, Map<String, dynamic> task) async {
    try {
      await _firestore
          .collection('Users')
          .doc(userEmail.toLowerCase())
          .collection('Archived_Tasks')
          .doc(taskId)
          .delete();

      await _firestore
          .collection('Users')
          .doc(userEmail.toLowerCase())
          .collection('Deleted_Tasks')
          .doc(taskId)
          .set(task);

      print('Successfully deleted archived task and moved to Deleted_Tasks.');
    } catch (error) {
      print('Error deleting archived task: $error');
    }
  }

  Future<void> deleteCompletedTask(
      String userEmail, String taskId, Map<String, dynamic> task) async {
    try {
      await _firestore
          .collection('Users')
          .doc(userEmail.toLowerCase())
          .collection('Completed_Tasks')
          .doc(taskId)
          .delete();

      await _firestore
          .collection('Users')
          .doc(userEmail.toLowerCase())
          .collection('Deleted_Tasks')
          .doc(taskId)
          .set(task);

      print('Successfully deleted completed task and moved to Deleted_Tasks.');
    } catch (error) {
      print('Error deleting completed task: $error');
    }
  }

  Future<void> deleteTaskPermanently(String userEmail, String taskId) async {
    try {
      await _firestore
          .collection('Users')
          .doc(userEmail.toLowerCase())
          .collection('Deleted_Tasks')
          .doc(taskId)
          .delete();

      print('Successfully deleted task permanently from Deleted_Tasks.');
    } catch (error) {
      print('Error deleting task permanently: $error');
    }
  }
}
