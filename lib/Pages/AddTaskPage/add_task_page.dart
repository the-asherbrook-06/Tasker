import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasker/Services/Data/CRUD/firestore_add_task.dart';

class AddTaskPage extends StatefulWidget {
  final Function onTaskAdded;

  const AddTaskPage({super.key, required this.onTaskAdded});

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController attachmentController = TextEditingController();

  DateTime? dueDate;
  String? selectedCategory;
  List<String> priorities = ['High', 'Medium', 'Low'];
  String? selectedPriority;

  final List<String> categories = ['Work', 'Personal', 'Study', 'Others'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Task Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Task Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: attachmentController,
              decoration: const InputDecoration(
                labelText: 'Attachments (Seperated by commas)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
              value: selectedCategory,
              items: categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(
                    category,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            const Text('Priority'),
            Wrap(
              spacing: 8.0,
              children: priorities.map((priority) {
                return ChoiceChip(
                  label: Text(priority),
                  selected: selectedPriority == priority,
                  onSelected: (selected) {
                    setState(() {
                      selectedPriority = selected ? priority : null;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(dueDate == null
                    ? 'Due Date: Not selected'
                    : 'Due Date: ${DateFormat.yMd().format(dueDate!)}'),
                TextButton(
                  onPressed: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: dueDate ?? DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null && pickedDate != dueDate) {
                      setState(() {
                        dueDate = pickedDate;
                      });
                    }
                  },
                  child: const Text('Select Due Date'),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                if (titleController.text.isNotEmpty) {
                  final taskData = {
                    'Title': titleController.text,
                    'Description': descriptionController.text,
                    'Priority': selectedPriority,
                    'Category': selectedCategory,
                    'DueDate':
                        dueDate != null ? Timestamp.fromDate(dueDate!) : null,
                    'Attachments': attachmentController.text.split(','),
                  };

                  final userEmail = FirebaseAuth.instance.currentUser?.email;

                  if (userEmail == null) {
                    print("User is not authenticated.");
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('User is not authenticated.')),
                    );
                    return;
                  }

                  const taskType = 'Ongoing_Tasks';

                  try {
                    final firestoreAddTask = FirestoreAddTask();
                    await firestoreAddTask.addTask(
                        userEmail, taskType, taskData);
                    widget.onTaskAdded();
                    Navigator.pop(context);
                  } catch (e) {
                    print("Failed to add task: $e");
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to add task: $e')),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a task title.')),
                  );
                }
              },
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  Theme.of(context).colorScheme.primary,
                ),
              ),
              child: Text(
                'Add Task',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
