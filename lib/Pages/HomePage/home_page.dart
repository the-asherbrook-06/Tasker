import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasker/Pages/MoreTasksPage/more_tasks_page.dart';
import 'package:tasker/Pages/UserPreferences/user_preferences.dart';
import 'package:tasker/Pages/AddTaskPage/add_task_page.dart';
import 'package:tasker/Services/Data/Fetcher/firestore_fetch_tasks.dart';
import 'package:tasker/Services/Data/CRUD/firestore_revert_complete_task.dart';
import 'package:tasker/Services/Data/CRUD/firestore_complete_task.dart';
import 'package:tasker/Services/Data/CRUD/firestore_archive_task.dart';
import 'package:tasker/Services/Data/CRUD/firestore_delete_task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreTasks _fetchTasks = FirestoreTasks();
  final FirestoreCompleteTask _completeTaskService = FirestoreCompleteTask();
  final FirestoreNotCompleteTask _revertCompleteTaskService =
      FirestoreNotCompleteTask();
  final FirestoreArchiveTask _archiveTaskService = FirestoreArchiveTask();
  final FirestoreDeleteTask _deleteTaskService = FirestoreDeleteTask();

  List<Map<String, dynamic>> _OngoingTasks = [];
  List<Map<String, dynamic>> _CompletedTasks = [];

  @override
  void initState() {
    super.initState();
    _loadAllTasks();
  }

  Future<void> _loadAllTasks() async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        print("Fetching tasks for user: ${user.email}");
        List<Map<String, dynamic>> ongoingTasks =
            await _fetchTasks.fetchAllTasks(user.email!, 'Ongoing_Tasks');
        List<Map<String, dynamic>> completedTasks =
            await _fetchTasks.fetchAllTasks(user.email!, 'Completed_Tasks');
        print("Fetched tasks: $ongoingTasks");

        setState(() {
          _OngoingTasks = ongoingTasks;
          _CompletedTasks = completedTasks;
        });
      } catch (e) {
        print("Failed to load tasks: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.refresh),
            onPressed: () {
              _loadAllTasks();
            },
          ),
          IconButton(
            icon: const Icon(CupertinoIcons.archivebox),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MoreTasksPage()),
              ).then((_) {
                _loadAllTasks(); // Correctly calling the method
              });
            },
          ),
          IconButton(
            icon: const Icon(CupertinoIcons.person_crop_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const UserPreferences()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.lightbulb_fill,
                    size: 20,
                    color: Theme.of(context).colorScheme.onTertiary,
                  ),
                  const SizedBox(width: 5.0),
                  Text(
                    'Welcome ${user?.displayName ?? "User"}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onTertiary,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "All Tasks",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  const SizedBox(height: 8.0),
                  const Divider(),
                  if (_OngoingTasks.isEmpty)
                    const Text("Yay! No tasks available."),
                  for (var task in _OngoingTasks)
                    _buildTaskItem(task, "All Tasks"),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Completed Tasks",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  const SizedBox(height: 8.0),
                  const Divider(),
                  if (_CompletedTasks.isEmpty)
                    const Text("Yay! No tasks available."),
                  for (var task in _CompletedTasks)
                    _buildTaskItem(task, "Completed Tasks"),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskPage(
                onTaskAdded: () {
                  _loadAllTasks();
                },
              ),
            ),
          );
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        label: Text(
          "Add Task",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        icon: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }

  Widget _buildTaskItem(Map<String, dynamic>? task, String Title) {
    print("Incoming task: $task");
    if (task == null) {
      return const Text("No task data");
    }

    final taskData = task['Task']?['Task'] ?? task['Task'];
    if (taskData == null) {
      return const Text("No valid task data");
    }

    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        title: Text(
          taskData['Title']?.toString().toUpperCase() ?? "UNTITLED TASK",
          style: (Title == "All Tasks")
              ? Theme.of(context).textTheme.bodyLarge
              : Theme.of(context).textTheme.bodyLarge?.copyWith(
                    decoration: TextDecoration.lineThrough,
                    decorationThickness: 2.0,
                    decorationColor: Theme.of(context).colorScheme.onSurface,
                  ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text((taskData['Description'] != "")
                ? taskData['Description']
                : "No Description"),
            if (taskData['DueDate'] != null)
              Text(taskData['DueDate'].toDate().toString().substring(0, 10)),
          ],
        ),
        trailing: _buildPopupMenu(taskData, Title),
      ),
    );
  }

  Widget _buildPopupMenu(Map<String, dynamic> task, String Title) {
    return PopupMenuButton<String>(
      color: Theme.of(context).colorScheme.surfaceContainerHigh,
      elevation: 3,
      icon: Icon(
        CupertinoIcons.ellipsis_vertical,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      itemBuilder: (context) => [
        PopupMenuItem<String>(
          value: (Title == "All Tasks") ? 'complete' : 'not complete',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text((Title == "All Tasks")
                  ? 'Mark Completed'
                  : 'Mark Not Completed'),
              const SizedBox(width: 5),
              Icon(
                (Title == "All Tasks") ? Icons.check : Icons.close,
                size: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),
        if (Title == "All Tasks")
          PopupMenuItem<String>(
            value: 'archive',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Archive Task'),
                Icon(
                  CupertinoIcons.archivebox,
                  size: 18,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ),
        PopupMenuItem<String>(
          value: (Title == "All Tasks") ? 'delete ongoing' : 'delete completed',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Delete Task'),
              Icon(
                CupertinoIcons.trash,
                size: 18,
                color: Theme.of(context).colorScheme.error,
              ),
            ],
          ),
        ),
      ],
      onSelected: (value) async {
        final user = _auth.currentUser;
        if (user == null || task['TaskId'] == null) {
          print("Error: User or TaskId is null");
          return;
        }

        switch (value) {
          case 'complete':
            await _completeTaskService.completeTask(
                user.email!, task['TaskId'], task);
            break;
          case 'not complete':
            await _revertCompleteTaskService.notCompleteTask(
                user.email!, task['TaskId'], task);
            break;
          case 'archive':
            await _archiveTaskService.archiveTask(
                user.email!, task['TaskId'], task);
            break;
          case 'delete ongoing':
            await _deleteTaskService.deleteOngoingTask(
                user.email!, task['TaskId'], task);
            break;
          case 'delete completed':
            await _deleteTaskService.deleteCompletedTask(
                user.email!, task['TaskId'], task);
            break;
        }
        _loadAllTasks();
      },
    );
  }
}
