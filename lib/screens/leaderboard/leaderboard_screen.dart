import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  final DatabaseReference _leaderboardRef = FirebaseDatabase.instance.ref('leaderboard');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
      ),
      body: StreamBuilder(
        stream: _leaderboardRef.orderByChild('totalWinnings').limitToLast(10).onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData && !snapshot.hasError && snapshot.data!.snapshot.value != null) {
            final data = Map<String, dynamic>.from(snapshot.data!.snapshot.value as Map);
            final leaderboardEntries = data.entries.map((entry) {
              return {
                'username': entry.value['username'],
                'totalWinnings': entry.value['totalWinnings'],
                'photoURL': entry.value['photoURL'],
              };
            }).toList();

            leaderboardEntries.sort((a, b) => b['totalWinnings'].compareTo(a['totalWinnings']));

            return ListView.builder(
              itemCount: leaderboardEntries.length,
              itemBuilder: (context, index) {
                final entry = leaderboardEntries[index];
                final rank = index + 1;

                return Card(
                  elevation: 4.0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: _getRankColor(rank),
                      child: Text(
                        '$rank',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Row(
                      children: [
                        if (entry['photoURL'] != null)
                          CircleAvatar(
                            backgroundImage: NetworkImage(entry['photoURL']),
                            radius: 15,
                          )
                        else
                          const CircleAvatar(
                            radius: 15,
                            child: Icon(Icons.person),
                          ),
                        const SizedBox(width: 8),
                        Text(
                          entry['username'],
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    trailing: Text(
                      entry['totalWinnings'].toString(),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ),
                );
              },
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return const Center(child: Text('No leaderboard data found.'));
        },
      ),
    );
  }

  Color _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return Colors.amber;
      case 2:
        return Colors.grey[400]!;
      case 3:
        return Colors.brown[400]!;
      default:
        return Theme.of(context).colorScheme.primary.withAlpha(153);
    }
  }
}
