import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.monetization_on,
                size: 100,
                color: Colors.white,
              ),
              const SizedBox(height: 20),
              Text(
                'Welcome to Spin and Win!',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 20),
              Text(
                'Spin the wheel to win exciting prizes!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => context.go('/login'),
                child: const Text('Get Started'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
