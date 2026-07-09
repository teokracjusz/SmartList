import 'package:flutter/material.dart';

import '../../../shared/models/smart_list.dart';
import '../../../shared/models/task.dart';

class TaskListScreen extends StatefulWidget {
  final SmartList smartList;

  const TaskListScreen({
    super.key,
    required this.smartList,
  });

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final TextEditingController _taskController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _showEditTaskDialog(Task task) {
  _taskController.text = task.name;

  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: const Text("Edytuj zadanie"),
        content: Form(
          key: _formKey,
          child: TextFormField(
            controller: _taskController,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: "Nazwa zadania",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Podaj nazwę zadania";
              }
              return null;
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _taskController.clear();
              Navigator.pop(context);
            },
            child: const Text("Anuluj"),
          ),
          FilledButton(
            onPressed: () {
              if (!_formKey.currentState!.validate()) return;

              setState(() {
                task.name = _taskController.text.trim();
              });

              _taskController.clear();
              Navigator.pop(context);
            },
            child: const Text("Zapisz"),
          ),
        ],
      );
    },
  );
}

  void _showAddTaskDialog() {
    _taskController.clear();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Nowe zadanie'),
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: _taskController,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Nazwa zadania',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Podaj nazwę zadania';
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _taskController.clear();
                Navigator.pop(context);
              },
              child: const Text('Anuluj'),
            ),
            FilledButton(
              onPressed: () {
                if (!_formKey.currentState!.validate()) {
                  return;
                }

                setState(() {
                  widget.smartList.tasks.add(
  Task(
    name: _taskController.text.trim(),
  ),
);

widget.smartList.tasks.sort((a, b) {
  if (a.isDone == b.isDone) return 0;
  return a.isDone ? 1 : -1;
});
                });

                _taskController.clear();
                Navigator.pop(context);
              },
              child: const Text('Dodaj'),
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
        title: Text(widget.smartList.name),
      ),
      body: widget.smartList.tasks.isEmpty
          ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.playlist_add_check,
                    size: 70,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Brak zadań',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Dodaj swoje pierwsze zadanie',
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: widget.smartList.tasks.length,
              itemBuilder: (context, index) {
                final task = widget.smartList.tasks[index];

                return Dismissible(
  key: ValueKey(task),

  direction: DismissDirection.horizontal,

  background: Container(
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.only(left: 24),
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(12),
    ),
    child: const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.edit, color: Colors.white),
        SizedBox(width: 8),
        Text(
          "Edytuj",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  ),

  secondaryBackground: Container(
    alignment: Alignment.centerRight,
    padding: const EdgeInsets.only(right: 24),
    decoration: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.circular(12),
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

  confirmDismiss: (direction) async {
    if (direction == DismissDirection.startToEnd) {
      _showEditTaskDialog(task);
      return false;
    }

    return await showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Usuń zadanie"),
            content: Text(
              'Czy usunąć "${task.name}"?',
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
      widget.smartList.tasks.remove(task);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Zadanie usunięte"),
      ),
    );
  },

  child: Card(
    margin: const EdgeInsets.only(bottom: 12),
    child: CheckboxListTile(
      value: task.isDone,
      onChanged: (value) {
        setState(() {
          task.isDone = value ?? false;

          widget.smartList.tasks.sort((a, b) {
            if (a.isDone == b.isDone) return 0;
            return a.isDone ? 1 : -1;
          });
        });
      },
      title: Text(
        task.name,
        style: TextStyle(
          decoration: task.isDone
              ? TextDecoration.lineThrough
              : TextDecoration.none,
          color: task.isDone ? Colors.grey : null,
        ),
      ),
    ),
  ),
);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}