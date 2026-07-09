import 'package:flutter/material.dart';
import '../../task_list/screens/task_list_screen.dart';
import '../../../shared/models/smart_list.dart';
import '../widgets/smart_list_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final List<SmartList> _lists = [];
  final TextEditingController _listNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void _showEditDialog(int index) {
  _listNameController.text = _lists[index].name;

  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: const Text("Edytuj listę"),
        content: Form(
          key: _formKey,
          child: TextFormField(
            controller: _listNameController,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: "Nazwa listy",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              final name = value?.trim() ?? "";

              if (name.isEmpty) {
                return "Podaj nazwę listy";
              }

              final exists = _lists.asMap().entries.any(
                (entry) =>
                    entry.key != index &&
                    entry.value.name.toLowerCase() == name.toLowerCase(),
              );

              if (exists) {
                return "Lista o tej nazwie już istnieje";
              }

              return null;
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _listNameController.clear();
              Navigator.pop(context);
            },
            child: const Text("Anuluj"),
          ),
          FilledButton(
            onPressed: () {
              if (!_formKey.currentState!.validate()) return;

              setState(() {
                _lists[index].name = _listNameController.text.trim();
              });

              _listNameController.clear();
              Navigator.pop(context);
            },
            child: const Text("Zapisz"),
          ),
        ],
      );
    },
  );
}

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
            return Dismissible(
  key: ValueKey(_lists[index]),

  direction: DismissDirection.horizontal,

 secondaryBackground: Container(
  alignment: Alignment.centerRight,
  padding: const EdgeInsets.only(right: 24),
  decoration: BoxDecoration(
    color: Colors.red,
    borderRadius: BorderRadius.circular(18),
  ),
  child: const Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        "Usuń",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(width: 8),
      Icon(Icons.delete, color: Colors.white),
    ],
  ),
),

  background: Container(
  alignment: Alignment.centerLeft,
  padding: const EdgeInsets.only(left: 24),
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(18),
  ),
  child: const Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(
        Icons.edit,
        color: Colors.white,
        size: 30,
      ),
      SizedBox(width: 8),
      Text(
        "Edytuj",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  ),
),

  confirmDismiss: (direction) async {
  if (direction == DismissDirection.startToEnd) {
    _showEditDialog(index);
    return false;
  }

  return await showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Usuń listę"),
          content: Text(
            'Czy usunąć listę "${_lists[index].name}"?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Anuluj"),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text("Usuń"),
            ),
          ],
        ),
      ) ??
      false;

  },

  onDismissed: (_) {
    setState(() { 
      _lists.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Lista usunięta"),
      ),
    );
  },

  child: SmartListCard(
    smartList: _lists[index],
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => TaskListScreen(
            smartList: _lists[index],
          ),
        ),
      ).then((_) {
        setState(() {});
      });
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
      _lists.add(
  SmartList(
  name: listName,
),
);
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