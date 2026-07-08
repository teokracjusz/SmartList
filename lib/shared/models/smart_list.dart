import 'task.dart';

class SmartList {
  String name;
  List<Task> tasks;

  SmartList({
    required this.name,
    List<Task>? tasks,
  }) : tasks = tasks ?? [];
}