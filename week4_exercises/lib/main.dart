import 'package:flutter/material.dart';
import 'list_view_exercise.dart';
import 'grid_view_exercise.dart';
import 'shared_prefs_exercise.dart';
import 'async_exercise.dart';
import 'factorial_isolate_exercise.dart';
void main() {
  runApp(const Week4App());
}
class Week4App extends StatelessWidget {
  const Week4App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Week 4 Exercises',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      routes: {
        ListViewExerciseScreen.routeName: (_) => const ListViewExerciseScreen(),
        GridViewExerciseScreen.routeName: (_) => const GridViewExerciseScreen(),
        SharedPrefsExerciseScreen.routeName: (_) =>
            const SharedPrefsExerciseScreen(),
        AsyncExerciseScreen.routeName: (_) => const AsyncExerciseScreen(),
        FactorialIsolateScreen.routeName: (_) =>
            const FactorialIsolateScreen(),
      },
    );
  }
}
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final items = [
      HomeItem(
        title: '1. ListView Contacts',
        subtitle: 'Scrollable contact list with avatar',
        route: ListViewExerciseScreen.routeName,
      ),
      HomeItem(
        title: '2. GridView Gallery',
        subtitle: 'GridView.count & GridView.extent',
        route: GridViewExerciseScreen.routeName,
      ),
      HomeItem(
        title: '3. Shared Preferences',
        subtitle: 'Save & show user info',
        route: SharedPrefsExerciseScreen.routeName,
      ),
      HomeItem(
        title: '4. Async Loading',
        subtitle: 'Show text after delay',
        route: AsyncExerciseScreen.routeName,
      ),
      HomeItem(
        title: '5. Isolate Factorial',
        subtitle: 'Heavy compute in background',
        route: FactorialIsolateScreen.routeName,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Week 4 Exercises'),
      ),
      body: ListView.separated(
        itemCount: items.length,
        separatorBuilder: (_, __) => const Divider(height: 0),
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            title: Text(item.title),
            subtitle: Text(item.subtitle),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.pushNamed(context, item.route);
            },
          );
        },
      ),
    );
  }
}
class HomeItem {
  final String title;
  final String subtitle;
  final String route;

  const HomeItem({
    required this.title,
    required this.subtitle,
    required this.route,
  });
}
