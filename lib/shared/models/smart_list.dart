import 'task.dart';

class SmartList {
  String name;
  List<Task> tasks;

  SmartList({
    required this.name,
    List<Task>? tasks,
  }) : tasks = tasks ?? [];

  int get completedTasks {
    return tasks.where((task) => task.isDone).length;
  }

  double get progress {
    if (tasks.isEmpty) return 0.0;
    return completedTasks / tasks.length;
  }
}