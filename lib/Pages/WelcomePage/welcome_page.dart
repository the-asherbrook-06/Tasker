import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasker/services/authentication/authentication_service.dart';
import 'package:tasker/Pages/HomePage/home_page.dart';

class WelcomePage extends StatelessWidget {
  final AuthenticationService _authService = AuthenticationService();

  WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SizedBox(height: 100),
          Text(
            'Tasker',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
            textAlign: TextAlign.center,
          ),
          Text(
            'Your tasks, organized.',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          const Image(
            image: AssetImage('lib/Assets/Images/WelcomePage/welcome_image.png'),
            height: 350,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 50),
          Center(
            child: SizedBox(
              width: 250,
              child: ElevatedButton.icon(
                onPressed: () async {
                  User? user = await _authService.signInWithGoogle();
                  if (user != null) {
                    if (context.mounted) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                      );
                    }
                  } else {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Google Sign-In failed')),
                      );
                    }
                  }
                },
                icon: const FaIcon(FontAwesomeIcons.google, size: 18),
                label: const Text('Sign in with Google'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
