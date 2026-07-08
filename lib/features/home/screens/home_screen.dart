import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SmartList'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           const Center(
  child: Text(
    'Wszystko, co ważne. W jednym miejscu.',
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Colors.black54,
    ),
  ),
),

            const SizedBox(height: 32),

           const Center(
  child: Text(
    '📋 Moje listy',
    style: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
  ),
),

            const SizedBox(height: 20),

            Expanded(
              child: Card(
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
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: const Text('Nowa lista'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}