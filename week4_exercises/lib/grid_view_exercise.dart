import 'package:flutter/material.dart';

class GridViewExerciseScreen extends StatelessWidget {
  static const String routeName = '/grid-view-exercise';
  const GridViewExerciseScreen({super.key});
  List<Widget> buildFixedColumnItems() {
    return List.generate(12, (index) {
      final itemNumber = index + 1;
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.blue.shade100,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.photo, size: 32),
            const SizedBox(height: 8),
            Text('Item $itemNumber'),
          ],
        ),
      );
    });
  }
  List<Widget> buildResponsiveItems() {
    return List.generate(12, (index) {
      final itemNumber = index + 1;
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.green.shade100,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.image, size: 32),
            const SizedBox(height: 8),
            Text('Item $itemNumber'),
          ],
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GridView Gallery'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Fixed Column Grid',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 8,  
              crossAxisSpacing: 8,
              childAspectRatio: 1,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: buildFixedColumnItems(),
            ),
            const SizedBox(height: 24),
            const Text(
              'Responsive Grid',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            GridView.extent(
              maxCrossAxisExtent: 150,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.8,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: buildResponsiveItems(),
            ),
          ],
        ),
      ),
    );
  }
}
