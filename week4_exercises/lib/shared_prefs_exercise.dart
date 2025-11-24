import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsExerciseScreen extends StatefulWidget {
  static const String routeName = '/shared-prefs-exercise';
  const SharedPrefsExerciseScreen({super.key});
  @override
  State<SharedPrefsExerciseScreen> createState() =>
      _SharedPrefsExerciseScreenState();
}
class _SharedPrefsExerciseScreenState extends State<SharedPrefsExerciseScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String _displayText = 'No saved user';
  String? _lastSavedTime;
  static const _keyName = 'user_name';
  static const _keyAge = 'user_age';
  static const _keyEmail = 'user_email';
  static const _keySavedAt = 'saved_at';
  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final ageText = _ageController.text.trim();

    if (name.isEmpty) {
      _showMessage('Please enter a name');
      return;
    }
    int? age;
    if (ageText.isNotEmpty) {
      age = int.tryParse(ageText);
    }
    await prefs.setString(_keyName, name);
    await prefs.setString(_keyEmail, email);
    if (age != null) {
      await prefs.setInt(_keyAge, age);
    } else {
      await prefs.remove(_keyAge);
    }
    final now = DateTime.now().toIso8601String();
    await prefs.setString(_keySavedAt, now);
    _showMessage('Data saved');
  }
  Future<void> _showData() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString(_keyName);
    final email = prefs.getString(_keyEmail);
    final age = prefs.getInt(_keyAge);
    final savedAt = prefs.getString(_keySavedAt);
    if (name == null) {
      setState(() {
        _displayText = 'No saved user';
        _lastSavedTime = null;
      });
      _showMessage('No data available');
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
      _displayText = buffer.toString().trim();
      _lastSavedTime = savedAt;
    });
  }
  Future<void> _clearData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyName);
    await prefs.remove(_keyAge);
    await prefs.remove(_keyEmail);
    await prefs.remove(_keySavedAt);

    setState(() {
      _displayText = 'No saved user';
      _lastSavedTime = null;
    });

    _showMessage('Data cleared');
  }
  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final timeText =
        _lastSavedTime != null ? 'Last saved at: $_lastSavedTime' : '';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared Preferences'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Age (optional)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _emailController,
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
                    onPressed: _saveData,
                    child: const Text('Save Name'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _showData,
                    child: const Text('Show Name'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: _clearData,
                child: const Text('Clear'),
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                _displayText,
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
