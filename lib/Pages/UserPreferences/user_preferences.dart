import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasker/Pages/WelcomePage/welcome_page.dart';
import 'package:tasker/Services/Authentication/authentication_service.dart';

final AuthenticationService _authService = AuthenticationService();

class UserPreferences extends StatefulWidget {
  const UserPreferences({super.key});

  @override
  _UserPreferencesState createState() => _UserPreferencesState();
}

class _UserPreferencesState extends State<UserPreferences> {
  final List<String> _taskCategories = [
    'Home',
    'Work',
    'Personal',
    'Studies',
    'Business',
    'Entertainment',
    'Health',
    'Other'
  ];
  final List<String> _selectedCategories = ['Home', 'Work', 'Personal', 'Other'];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _loadUserPreferences();
  }

  void _loadUserPreferences() async {
    final DocumentSnapshot userPrefSnapshot =
        await _firestore.collection('User_Preferences').doc(user?.uid).get();

    if (userPrefSnapshot.exists) {
      setState(() {
        final prefs = userPrefSnapshot.data() as Map<String, dynamic>;
        if (prefs['taskCategories'] != null) {
          _selectedCategories.clear();
          _selectedCategories
              .addAll(List<String>.from(prefs['taskCategories']));
        }
      });
    }
  }

  void _saveUserPreferences() async {
    await _firestore.collection('User_Preferences').doc(user?.uid).set({
      'taskCategories': _selectedCategories,
    });
  }

  Widget _buildTaskCategorySelector() {
    return Wrap(
      spacing: 8.0,
      children: _taskCategories.map((String category) {
        final isSelected = _selectedCategories.contains(category);
        return FilterChip(
          label: Text(category),
          selected: isSelected,
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                _selectedCategories.add(category);
              } else {
                _selectedCategories.remove(category);
              }
              _saveUserPreferences();
            });
          },
          selectedColor: Theme.of(context).colorScheme.primary,
          checkmarkColor: Theme.of(context).colorScheme.onPrimary,
          labelStyle: TextStyle(
            color: isSelected
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.onSurface,
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Preferences'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            onPressed: () => _showLogoutConfirmationDialog(context),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: user?.photoURL != null
                      ? NetworkImage(user!.photoURL!)
                      : const AssetImage('assets/default_profile.png')
                          as ImageProvider,
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.displayName ?? 'No Name',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      user?.email ?? 'No Email',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'General Settings',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Divider(),
                const SizedBox(height: 10),
                Text(
                  "Preferred Categories (Beta)",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 5),
                _buildTaskCategorySelector(),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'App Settings',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Divider(),
                const SizedBox(height: 10),
                SwitchListTile(
                  title: const Text('Enable Notifications'),
                  subtitle:
                      const Text('Allow Notifications to be pushed (Beta)'),
                  value: true,
                  onChanged: (bool value) {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Account Settings',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Divider(),
                const SizedBox(height: 10),
                ListTile(
                  leading: const Icon(Icons.delete_forever, color: Colors.red),
                  title: const Text('Delete Account'),
                  subtitle:
                      const Text('Permanently delete your account (Beta)'),
                  onTap: () => _showDeleteAccountConfirmationDialog(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
          icon: const Icon(
            Icons.warning_amber_rounded,
            size: 40,
            color: Colors.red,
          ),
          title: const Text('Logout'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Are you sure you want to log out?'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  Theme.of(context).colorScheme.primary,
                ),
              ),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
            OutlinedButton(
              onPressed: () {
                _authService.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WelcomePage(),
                  ),
                );
              },
              style: ButtonStyle(
                side: WidgetStatePropertyAll(
                  BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteAccountConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
          title: const Text('Delete Account'),
          icon: const Icon(
            Icons.warning_amber_rounded,
            size: 40,
            color: Colors.red,
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Are you sure you want to permanently delete your account?'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  Theme.of(context).colorScheme.primary,
                ),
              ),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
