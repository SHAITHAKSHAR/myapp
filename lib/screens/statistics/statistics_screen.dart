import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myapp/providers/auth_provider.dart';

class StatisticsScreen extends StatelessWidget {
  final AuthProvider authProvider;

  const StatisticsScreen({super.key, required this.authProvider});

  @override
  Widget build(BuildContext context) {
    final user = authProvider.user;
    final DatabaseReference? spinsRef = user != null ? FirebaseDatabase.instance.ref('spins/${user.uid}') : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
      ),
      body: spinsRef == null
          ? const Center(child: Text('Please log in to see your statistics.'))
          : StreamBuilder(
              stream: spinsRef.onValue,
              builder: (context, snapshot) {
                if (snapshot.hasData && !snapshot.hasError && snapshot.data!.snapshot.value != null) {
                  final data = Map<String, dynamic>.from(snapshot.data!.snapshot.value as Map);
                  final spins = data.entries.map((entry) {
                    return int.parse(entry.value['result']);
                  }).toList();

                  final totalSpins = spins.length;
                  final totalWinnings = spins.fold<int>(0, (previousValue, element) => previousValue + element);
                  final averageWinnings = totalSpins > 0 ? totalWinnings / totalSpins : 0;

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _StatisticCard(
                          label: 'Total Spins',
                          value: totalSpins.toString(),
                          icon: Icons.casino,
                        ),
                        const SizedBox(height: 16),
                        _StatisticCard(
                          label: 'Total Winnings',
                          value: totalWinnings.toString(),
                          icon: Icons.monetization_on,
                        ),
                        const SizedBox(height: 16),
                        _StatisticCard(
                          label: 'Average Winnings',
                          value: averageWinnings.toStringAsFixed(2),
                          icon: Icons.functions,
                        ),
                      ],
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                return const Center(child: Text('No statistics found.'));
              },
            ),
    );
  }
}

class _StatisticCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatisticCard({required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(
              icon,
              size: 40,
              color: colorScheme.primary,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
