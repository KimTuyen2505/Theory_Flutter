import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FactorialIsolateScreen extends StatefulWidget {
  static const String routeName = '/factorial-isolate';
  const FactorialIsolateScreen({super.key});
  @override
  State<FactorialIsolateScreen> createState() => FactorialIsolateScreenState();
}
String calculateFactorial(int n) {
  BigInt result = BigInt.one;
  for (var i = 1; i <= n; i++) {
    result *= BigInt.from(i);
  }
  return result.toString();
}
class FactorialIsolateScreenState extends State<FactorialIsolateScreen> {
  final TextEditingController controller =
      TextEditingController(text: '30000');
  bool isCalculating = false;
  String? resultPreview;
  Future<void> startCalculation() async {
    final text = controller.text.trim();
    final n = int.tryParse(text);
    if (n == null || n <= 0) {
      showMessage('Please enter a positive integer');
      return;
    }
    setState(() {
      isCalculating = true;
      resultPreview = null;
    });
    try {
      final fullResult = await compute(calculateFactorial, n);
      final previewLength = min(200, fullResult.length);
      final preview = fullResult.substring(0, previewLength);
      setState(() {
        resultPreview = 'Length: ${fullResult.length} digits\n\n'
            'First digits:\n$preview...';
      });
    } catch (e) {
      showMessage('Error: $e');
    } finally {
      if (mounted) {
        setState(() {
          isCalculating = false;
        });
      }
    }
  }
  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final resultWidget = resultPreview != null
        ? SingleChildScrollView(
            child: Text(
              resultPreview!,
              style: const TextStyle(fontSize: 14),
            ),
          )
        : const Text('No result yet');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Factorial with Isolate'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Calculates n! using a background isolate.\n'
              'Default value is 30000 (very large).',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'n',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isCalculating ? null : startCalculation,
                child: const Text('Calculate factorial'),
              ),
            ),
            const SizedBox(height: 16),
            if (isCalculating) ...[
              const CircularProgressIndicator(),
              const SizedBox(height: 8),
              const Text('Calculating in background isolate...'),
            ],
            const SizedBox(height: 16),
            Expanded(child: resultWidget),
          ],
        ),
      ),
    );
  }
}
