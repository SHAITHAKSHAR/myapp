import 'package:flutter/material.dart';
import 'package:myapp/providers/challenges_provider.dart';
import 'package:provider/provider.dart';

class ChallengesScreen extends StatelessWidget {
  const ChallengesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Challenges'),
      ),
      body: Consumer<ChallengesProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.challenges.length,
            itemBuilder: (context, index) {
              final challenge = provider.challenges[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(challenge.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(challenge.description),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: challenge.progress / challenge.goal,
                        backgroundColor: Colors.grey[300],
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                      ),
                      const SizedBox(height: 4),
                      Text('${challenge.progress} / ${challenge.goal}'),
                    ],
                  ),
                  trailing: challenge.isCompleted
                      ? ElevatedButton(
                          onPressed: () {
                            provider.claimReward(challenge.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Reward of ${challenge.reward} points claimed!'),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                          child: const Text('Claim Reward'),
                        )
                      : ElevatedButton(
                          onPressed: null,
                          child: const Text('In Progress'),
                        ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
