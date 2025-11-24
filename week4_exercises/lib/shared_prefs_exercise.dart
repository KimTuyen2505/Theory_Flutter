import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsExerciseScreen extends StatefulWidget {
  static const String routeName = '/shared-prefs-exercise';
  const SharedPrefsExerciseScreen({super.key});
  @override
  State<SharedPrefsExerciseScreen> createState() =>
      SharedPrefsExerciseScreenState();
}
class SharedPrefsExerciseScreenState extends State<SharedPrefsExerciseScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String displayText = 'No saved user';
  String? lastSavedTime;
  static const keyName = 'user_name';
  static const keyAge = 'user_age';
  static const keyEmail = 'user_email';
  static const keySavedAt = 'saved_at';
  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final ageText = ageController.text.trim();

    if (name.isEmpty) {
      showMessage('Please enter a name');
      return;
    }
    int? age;
    if (ageText.isNotEmpty) {
      age = int.tryParse(ageText);
    }
    await prefs.setString(keyName, name);
    await prefs.setString(keyEmail, email);
    if (age != null) {
      await prefs.setInt(keyAge, age);
    } else {
      await prefs.remove(keyAge);
    }
    final now = DateTime.now().toIso8601String();
    await prefs.setString(keySavedAt, now);
    showMessage('Data saved');
  }
  Future<void> showData() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString(keyName);
    final email = prefs.getString(keyEmail);
    final age = prefs.getInt(keyAge);
    final savedAt = prefs.getString(keySavedAt);
    if (name == null) {
      setState(() {
        displayText = 'No saved user';
        lastSavedTime = null;
      });
      showMessage('No data available');
      return;
    }
    final buffer = StringBuffer()
      ..writeln('Name: $name');
    if (age != null) {
      buffer.writeln('Age: $age');
    }
    if (email != null && email.isNotEmpty) {
      buffer.writeln('Email: $email');
    }

    setState(() {
      displayText = buffer.toString().trim();
      lastSavedTime = savedAt;
    });
  }
  Future<void> clearData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(keyName);
    await prefs.remove(keyAge);
    await prefs.remove(keyEmail);
    await prefs.remove(keySavedAt);

    setState(() {
      displayText = 'No saved user';
      lastSavedTime = null;
    });

    showMessage('Data cleared');
  }
  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    emailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final timeText =
        lastSavedTime != null ? 'Last saved at: $lastSavedTime' : '';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared Preferences'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Age (optional)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email (optional)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: saveData,
                    child: const Text('Save Name'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: showData,
                    child: const Text('Show Name'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: clearData,
                child: const Text('Clear'),
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                displayText,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            if (timeText.isNotEmpty) ...[
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  timeText,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
