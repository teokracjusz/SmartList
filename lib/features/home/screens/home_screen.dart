import 'package:flutter/material.dart';
import '../../task_list/screens/task_list_screen.dart';
import '../../../shared/models/smart_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final List<SmartList> _lists = [];
  final TextEditingController _listNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
  child: _lists.isEmpty
      ? Card(
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
        )
      : ListView.builder(
          itemCount: _lists.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
  leading: const Icon(Icons.list_alt),
  title: Text(_lists[index].name),
  trailing: const Icon(Icons.chevron_right),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskListScreen(
      smartList: _lists[index],
),
      ),
    );
  },
),
            );
          },
        ),
),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Nowa lista'),
    content: Form(
  key: _formKey,
  child: TextFormField(
    controller: _listNameController,
    autofocus: true,
    decoration: const InputDecoration(
      labelText: 'Nazwa listy',
      border: OutlineInputBorder(),
    ),
    validator: (value) {
  final listName = value?.trim() ?? '';

  if (listName.isEmpty) {
    return 'Podaj nazwę listy';
  }

  final exists = _lists.any(
    (list) => list.name.toLowerCase() == listName.toLowerCase(),
  );

  if (exists) {
    return 'Lista o tej nazwie już istnieje';
  }

  return null;
},
  ),
),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Anuluj'),
          ),
          FilledButton(
  onPressed: () {

    if (!_formKey.currentState!.validate()) {
    return;
  }
    
    final listName = _listNameController.text.trim();



    setState(() {
      _lists.add(SmartList(name: listName));
    });

    _listNameController.clear();

    Navigator.pop(context);
  },
  child: const Text('Utwórz'),
),
        ],
      );
    },
  );
},
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