import 'package:flutter/material.dart';

class ListViewExerciseScreen extends StatelessWidget {
  static const String routeName = '/list-view-exercise';
  const ListViewExerciseScreen({super.key});
  final List<Map<String, String>> contacts = const [
    {'name': 'Nguyen Dang Kim Tuyen 0', 'phone': '+84 983 253 551'},
    {'name': 'Nguyen Dang Kim Tuyen 1', 'phone': '+84 983 253 551'},
    {'name': 'Nguyen Dang Kim Tuyen 2', 'phone': '+84 983 253 551'},
    {'name': 'Nguyen Dang Kim Tuyen 3', 'phone': '+84 983 253 551'},
    {'name': 'Nguyen Dang Kim Tuyen 4', 'phone': '+84 983 253 551'},
    {'name': 'Nguyen Dang Kim Tuyen 5', 'phone': '+84 983 253 551'},
    {'name': 'Nguyen Dang Kim Tuyen 6', 'phone': '+84 983 253 551'},
    {'name': 'Nguyen Dang Kim Tuyen 7', 'phone': '+84 983 253 551'},
    {'name': 'Nguyen Dang Kim Tuyen 8', 'phone': '+84 983 253 551'},
    {'name': 'Nguyen Dang Kim Tuyen 9', 'phone': '+84 983 253 551'},
    {'name': 'Nguyen Dang Kim Tuyen 10', 'phone': '+84 983 253 551'},
    {'name': 'Nguyen Dang Kim Tuyen 11', 'phone': '+84 983 253 551'},
    {'name': 'Nguyen Dang Kim Tuyen 12', 'phone': '+84 983 253 551'},
    {'name': 'Nguyen Dang Kim Tuyen 13', 'phone': '+84 983 253 551'},
    {'name': 'Nguyen Dang Kim Tuyen 14', 'phone': '+84 983 253 551'},
    {'name': 'Nguyen Dang Kim Tuyen 15', 'phone': '+84 983 253 551'},
    {'name': 'Nguyen Dang Kim Tuyen 16', 'phone': '+84 983 253 551'},
    {'name': 'Nguyen Dang Kim Tuyen 17', 'phone': '+84 983 253 551'},
    {'name': 'Nguyen Dang Kim Tuyen 18', 'phone': '+84 983 253 551'},
    {'name': 'Nguyen Dang Kim Tuyen 19', 'phone': '+84 983 253 551'},
  
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts List'),
      ),
      body: ListView.separated(
        itemCount: contacts.length,
        separatorBuilder: (_, __) => const Divider(height: 0),
        itemBuilder: (context, index) {
          final contact = contacts[index];
          final name = contact['name'] ?? 'Unknown';
          final phone = contact['phone'] ?? '';

          return ListTile(
            leading: CircleAvatar(
              child: Text(
                name.isNotEmpty ? name[0] : '?',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            title: Text(name),
            subtitle: Text(phone),
          );
        },
      ),
    );
  }
}
