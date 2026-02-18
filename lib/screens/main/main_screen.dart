import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  final Widget child;

  const MainScreen({super.key, required this.child});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _locationToTabIndex(String location) {
    final index = <String>[
      '/',
      '/spin',
      '/history',
      '/leaderboard',
      '/statistics',
    ].indexWhere((path) => location.startsWith(path));
    return index < 0 ? 0 : index;
  }

  String _locationToTitle(String location) {
    if (location.startsWith('/spin')) return 'Spin and Win';
    if (location.startsWith('/history')) return 'Spin History';
    if (location.startsWith('/leaderboard')) return 'Leaderboard';
    if (location.startsWith('/statistics')) return 'Statistics';
    return 'Spin and Win';
  }

  void _onTabTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/spin');
        break;
      case 2:
        context.go('/history');
        break;
      case 3:
        context.go('/leaderboard');
        break;
      case 4:
        context.go('/statistics');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = _locationToTabIndex(location);
    final title = _locationToTitle(location);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            onPressed: () => context.go('/profile'),
            icon: CircleAvatar(
              backgroundImage: user?.photoURL != null ? NetworkImage(user!.photoURL!) : null,
              child: user?.photoURL == null ? const Icon(Icons.person) : null,
            ),
          ),
        ],
      ),
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => _onTabTapped(index, context),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.casino),
            label: 'Spin',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Leaderboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistics',
          ),
        ],
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
