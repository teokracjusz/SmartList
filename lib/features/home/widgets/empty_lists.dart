import 'package:flutter/material.dart';

class EmptyLists extends StatelessWidget {
  const EmptyLists({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(
              Icons.playlist_add_check_circle_outlined,
              size: 70,
            ),
            SizedBox(height: 16),
            Text(
              'Brak list',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Utwórz swoją pierwszą listę',
            ),
          ],
        ),
      ),
    );
  }
}