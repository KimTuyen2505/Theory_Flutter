import 'package:flutter/material.dart';

class AsyncExerciseScreen extends StatefulWidget {
  static const String routeName = '/async-exercise';
  const AsyncExerciseScreen({super.key});
  @override
  State<AsyncExerciseScreen> createState() => AsyncExerciseScreenState();
}
class AsyncExerciseScreenState extends State<AsyncExerciseScreen> {
  String message = "Loading user...";
  @override
  void initState() {
    super.initState();
    loadUser();
  }
  Future<void> loadUser() async {
    await Future.delayed(const Duration(seconds: 3)); 

    setState(() {
      message = "User loaded successfully!";
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Async Loading")),
      body: Center(
        child: Text(
          message,
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
