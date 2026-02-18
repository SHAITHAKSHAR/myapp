import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/providers/auth_provider.dart';

class HistoryScreen extends StatelessWidget {
  final AuthProvider authProvider;

  const HistoryScreen({super.key, required this.authProvider});

  @override
  Widget build(BuildContext context) {
    final user = authProvider.user;
    final DatabaseReference? spinsRef = user != null ? FirebaseDatabase.instance.ref('spins/${user.uid}') : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Spin History'),
      ),
      body: spinsRef == null
          ? const Center(child: Text('Please log in to see your spin history.'))
          : StreamBuilder(
              stream: spinsRef.orderByChild('timestamp').onValue,
              builder: (context, snapshot) {
                if (snapshot.hasData && !snapshot.hasError && snapshot.data!.snapshot.value != null) {
                  final data = Map<String, dynamic>.from(snapshot.data!.snapshot.value as Map);
                  final spins = data.entries.map((entry) {
                    return {
                      'key': entry.key,
                      'result': entry.value['result'],
                      'timestamp': entry.value['timestamp'],
                    };
                  }).toList();

                  spins.sort((a, b) => b['timestamp'].compareTo(a['timestamp']));

                  return ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: spins.length,
                    itemBuilder: (context, index) {
                      final spin = spins[index];
                      final dateTime = DateTime.parse(spin['timestamp']);
                      final formattedDate = DateFormat.yMMMd().format(dateTime);
                      final formattedTime = DateFormat.jm().format(dateTime);

                      return Card(
                        elevation: 4.0,
                        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.monetization_on,
                            color: Theme.of(context).colorScheme.primary,
                            size: 40,
                          ),
                          title: Text(
                            'You won: ${spin['result']}',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('$formattedDate at $formattedTime'),
                        ),
                      );
                    },
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                return const Center(child: Text('No spin history found.'));
              },
            ),
    );
  }
}
