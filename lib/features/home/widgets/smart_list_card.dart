import 'package:flutter/material.dart';

import '../../../shared/models/smart_list.dart';

class SmartListCard extends StatelessWidget {
  final SmartList smartList;
  final VoidCallback onTap;

  const SmartListCard({
    super.key,
    required this.smartList,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: [

                  const CircleAvatar(
  child: Icon(Icons.list_alt),
),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      smartList.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const Icon(Icons.chevron_right),
                ],
              ),

              const SizedBox(height: 18),

              Text(
                "${smartList.completedTasks} / ${smartList.tasks.length} wykonane",
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 10),

              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: LinearProgressIndicator(
                  value: smartList.progress,
                  minHeight: 9,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}