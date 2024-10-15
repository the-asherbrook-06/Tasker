import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:tasker/Pages/WelcomePage/welcome_page.dart';
import 'package:tasker/Pages/HomePage/home_page.dart';

import 'package:tasker/Themes/theme.dart';
import 'package:tasker/Themes/util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const TaskerApp());
}

class TaskerApp extends StatelessWidget {
  const TaskerApp({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Assistant", "Rubik");
    MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp(
      title: 'Tasker',
      debugShowCheckedModeBanner: false,
      theme: theme.light(),
      darkTheme: theme.dark(),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return WelcomePage();
          }
        },
      ),
      routes: {
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
