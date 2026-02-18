import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/providers/auth_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Sign In',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 24.0),
                  ElevatedButton.icon(
                    onPressed: () async {
                      try {
                        await Provider.of<AuthProvider>(context, listen: false).signInWithGoogle();
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())),
                          );
                        }
                      }
                    },
                    icon: const Icon(Icons.g_mobiledata),
                    label: const Text('Sign in with Google'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
