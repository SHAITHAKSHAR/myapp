import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myapp/providers/auth_provider.dart';
import 'package:myapp/providers/challenges_provider.dart';
import 'package:myapp/widgets/wheel_painter.dart';
import 'package:provider/provider.dart';

class SpinScreen extends StatefulWidget {
  final AuthProvider authProvider;

  const SpinScreen({super.key, required this.authProvider});

  @override
  State<SpinScreen> createState() => _SpinScreenState();
}

class _SpinScreenState extends State<SpinScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final _random = Random();
  final List<String> _items = [
    '100', '200', '300', '400', '500', '600', '700', '800'
  ];
  String? _result;
  DatabaseReference? _spinsRef;
  DatabaseReference? _leaderboardRef;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
      setState(() {});
    });

    final user = widget.authProvider.user;
    if (user != null) {
      _spinsRef = FirebaseDatabase.instance.ref('spins/${user.uid}');
      _leaderboardRef = FirebaseDatabase.instance.ref('leaderboard/${user.uid}');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _spin() {
    if (_controller.isAnimating) return;

    final int randomIndex = _random.nextInt(_items.length);
    final double randomAngle = (randomIndex / _items.length) * 2 * pi;

    _controller.reset();
    _controller.animateTo(
      randomAngle + (2 * pi * 5), // Spin 5 times
      curve: Curves.easeOutCubic,
    ).whenComplete(() {
      setState(() {
        _result = _items[randomIndex];
      });
      _handleSpinResult(int.parse(_result!));
    });
  }

  Future<void> _handleSpinResult(int winnings) async {
    final challengesProvider = Provider.of<ChallengesProvider>(context, listen: false);
    if (_spinsRef != null) {
      await _spinsRef!.push().set({
        'result': winnings.toString(),
        'timestamp': DateTime.now().toIso8601String(),
      });
    }

    if (_leaderboardRef != null) {
      _leaderboardRef!.runTransaction((Object? post) {
        final user = widget.authProvider.user;
        final username = user?.displayName ?? 'Anonymous';
        final photoURL = user?.photoURL;

        if (post == null) {
          return Transaction.success({
            'totalWinnings': winnings,
            'username': username,
            'photoURL': photoURL,
          });
        }

        final Map<String, dynamic> data = Map<String, dynamic>.from(post as Map);
        final int currentWinnings = data['totalWinnings'] ?? 0;
        return Transaction.success({
          'totalWinnings': currentWinnings + winnings,
          'username': username,
          'photoURL': photoURL,
        });
      });
    }

    final spinChallenge = challengesProvider.challenges.firstWhere((c) => c.id == '2');
    challengesProvider.updateProgress('2', spinChallenge.progress + 1);

    final pointsChallenge = challengesProvider.challenges.firstWhere((c) => c.id == '1');
    challengesProvider.updateProgress('1', pointsChallenge.progress + winnings);

    if (winnings == 800) {
      final jackpotChallenge = challengesProvider.challenges.firstWhere((c) => c.id == '3');
      challengesProvider.updateProgress('3', jackpotChallenge.progress + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Spin the Wheel'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Stack(
                alignment: Alignment.center,
                children: [
                  Transform.rotate(
                    angle: _controller.value,
                    child: CustomPaint(
                      size: const Size(300, 300),
                      painter: WheelPainter(items: _items),
                    ),
                  ),
                  Icon(
                    Icons.arrow_downward,
                    size: 50,
                    color: colorScheme.primary,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _spin,
                child: const Text('Spin!'),
              ),
              const SizedBox(height: 20),
              if (_result != null)
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Congratulations!',
                          style: textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'You won $_result!',
                          style: textTheme.displayMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
