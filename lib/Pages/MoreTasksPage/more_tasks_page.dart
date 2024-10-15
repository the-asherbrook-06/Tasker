import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasker/Services/Data/Fetcher/firestore_fetch_tasks.dart';
import 'package:tasker/Services/Data/CRUD/firestore_unarchive_task.dart';
import 'package:tasker/Services/Data/CRUD/firestore_restore_task.dart';
import 'package:tasker/Services/Data/CRUD/firestore_delete_task.dart';

class MoreTasksPage extends StatefulWidget {
  const MoreTasksPage({super.key});

  @override
  _MoreTasksPageState createState() => _MoreTasksPageState();
}

class _MoreTasksPageState extends State<MoreTasksPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreTasks _fetchTasks = FirestoreTasks();

  final FirestoreUnarchiveTask _unarchiveTaskService = FirestoreUnarchiveTask();
  final FirestoreRestoreTask _restoreTaskService = FirestoreRestoreTask();
  final FirestoreDeleteTask _deleteTaskService = FirestoreDeleteTask();

  List<Map<String, dynamic>> _archivedTasks = [];
  List<Map<String, dynamic>> _deletedTasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        print("Fetching archived and deleted tasks for user: ${user.email}");
        List<Map<String, dynamic>> archivedTasks =
            await _fetchTasks.fetchAllTasks(user.email!, 'Archived_Tasks');
        List<Map<String, dynamic>> deletedTasks =
            await _fetchTasks.fetchAllTasks(user.email!, 'Deleted_Tasks');

        print("Fetched archived tasks: $archivedTasks");
        print("Fetched deleted tasks: $deletedTasks");

        setState(() {
          _archivedTasks = archivedTasks;
          _deletedTasks = deletedTasks;
        });
      } catch (e) {
        print("Failed to load tasks: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("More Tasks"), actions: [
        IconButton(
          icon: const Icon(CupertinoIcons.refresh),
          onPressed: () {
            _loadTasks();
          },
        ),
      ]),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildTaskListSection("Archived Tasks", _archivedTasks),
            const SizedBox(height: 10),
            _buildTaskListSection("Deleted Tasks", _deletedTasks),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskListSection(String title, List<Map<String, dynamic>> tasks) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          const SizedBox(height: 8.0),
          const Divider(),
          if (tasks.isEmpty) const Text("Yaay! No tasks available."),
          for (var task in tasks) _buildTaskItem(task, title),
        ],
      ),
    );
  }

  Widget _buildTaskItem(Map<String, dynamic>? task, String taskType) {
    if (task == null) {
      return const Text("No task data");
    }
    if (taskType == 'Archived Tasks') task = task['Task'];
    if (task == null) {
      return const Text("No task data");
    }

    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        title: Text(
          task['Title'].toString().toUpperCase(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (task['Description'] != null) Text(task['Description']),
            if (task['DueDate'] != null)
              Text(task['DueDate'].toDate().toString().substring(0, 10)),
          ],
        ),
        trailing: _buildPopupMenu(task, taskType),
      ),
    );
  }

  Widget _buildPopupMenu(Map<String, dynamic> task, String taskType) {
    return PopupMenuButton<String>(
      color: Theme.of(context).colorScheme.surfaceContainerHigh,
      elevation: 3,
      icon: Icon(
        CupertinoIcons.ellipsis_vertical,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      itemBuilder: (context) => taskType == "Archived Tasks"
          ? _buildArchivedTaskMenu()
          : _buildDeletedTaskMenu(),
      onSelected: (value) async {
        final user = _auth.currentUser;
        if (user == null) return;

        switch (value) {
          case 'restore':
            taskType == "Archived Tasks"
                ? await _unarchiveTaskService.unarchiveTask(
                    user.email!, task['TaskId'], task)
                : await _restoreTaskService.restoreTask(
                    user.email!, task['TaskId'], task);
            break;
          case 'delete':
            await _deleteTaskService.deleteArchivedTask(
                user.email!, task['TaskId'], task);
            break;
          case 'delete_permanently':
            await _deleteTaskService.deleteTaskPermanently(
                user.email!, task['TaskId']);
            break;
        }
        _loadTasks();
      },
    );
  }

  List<PopupMenuItem<String>> _buildArchivedTaskMenu() {
    return [
      PopupMenuItem<String>(
        value: 'restore',
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Restore Task'),
            Icon(
              Icons.restore,
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
      ),
      PopupMenuItem<String>(
        value: 'delete',
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Delete'),
            const SizedBox(width: 5),
            Icon(
              CupertinoIcons.trash,
              color: Theme.of(context).colorScheme.error,
            ),
          ],
        ),
      ),
    ];
  }

  List<PopupMenuItem<String>> _buildDeletedTaskMenu() {
    return [
      PopupMenuItem<String>(
        value: 'restore',
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Restore Task'),
            Icon(
              Icons.restore,
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
      ),
      PopupMenuItem<String>(
        value: 'delete_permanently',
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Delete Permanently'),
            const SizedBox(width: 5),
            Icon(
              CupertinoIcons.trash,
              color: Theme.of(context).colorScheme.error,
            ),
          ],
        ),
      ),
    ];
  }
}
