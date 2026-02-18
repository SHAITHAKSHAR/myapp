import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/services/ad_service.dart';
import 'package:provider/provider.dart';
import 'package:myapp/providers/auth_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AdService _adService = AdService();

  @override
  void initState() {
    super.initState();
    _adService.loadRewardedAd();
  }

  void _showAdAndSpin() {
    _adService.showRewardedAd(() {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You got a free spin!')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome,',
                style: textTheme.titleLarge,
              ),
              Text(
                authProvider.user?.displayName ?? 'Player',
                style: textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(height: 32),
              _MenuButton(
                icon: Icons.casino,
                label: 'Spin the Wheel',
                onPressed: () => context.go('/spin'),
              ),
              const SizedBox(height: 16),
              _MenuButton(
                icon: Icons.history,
                label: 'View Spin History',
                onPressed: () => context.go('/history'),
              ),
              const SizedBox(height: 16),
              _MenuButton(
                icon: Icons.leaderboard,
                label: 'View Leaderboard',
                onPressed: () => context.go('/leaderboard'),
              ),
              const SizedBox(height: 16),
              _MenuButton(
                icon: Icons.bar_chart,
                label: 'View Statistics',
                onPressed: () => context.go('/statistics'),
              ),
              const SizedBox(height: 16),
              _MenuButton(
                icon: Icons.emoji_events,
                label: 'Daily Challenges',
                onPressed: () => context.go('/challenges'),
              ),
              const SizedBox(height: 16),
              _MenuButton(
                icon: Icons.ondemand_video,
                label: 'Watch Ad for a Free Spin',
                onPressed: _showAdAndSpin,
                isPrimary: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  const _MenuButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.isPrimary = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: isPrimary ? colorScheme.primaryContainer : colorScheme.surface,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                icon,
                size: 32,
                color: isPrimary ? colorScheme.onPrimaryContainer : colorScheme.primary,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  label,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                     color: isPrimary ? colorScheme.onPrimaryContainer : colorScheme.onSurface,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: isPrimary ? colorScheme.onPrimaryContainer : colorScheme.onSurface.withAlpha(153),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
