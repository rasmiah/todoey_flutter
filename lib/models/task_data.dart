import 'package:flutter/foundation.dart';
import 'Task.dart';
import 'package:collection/collection.dart';


class TaskData extends ChangeNotifier{
  List <Task> _tasks=[
    Task(name: 'buy milk', category: TaskCategory.errands),
    Task(name: 'find a job', category: TaskCategory.work),
    Task(name: 'do more flutter projects',category: TaskCategory.study),
  ];
  TaskCategory _activeFilter = TaskCategory.all;

  List<Task> get tasks {
    if (_activeFilter == TaskCategory.all) return List.unmodifiable(_tasks);
    return _tasks.where((t) => t.category == _activeFilter).toList();
  }

  int get taskCount {
    return _tasks.length;
  }

  TaskCategory get activeFilter => _activeFilter;
  void setFilter(TaskCategory c) {
    _activeFilter = c;
    notifyListeners();
  }

  void addTask(String newTaskTitle, {TaskCategory category = TaskCategory.general}) {
    _tasks.add(Task(name: newTaskTitle, category: category));
    notifyListeners();
  }

  void updateTask(Task task){
    task.toggleDone();
    notifyListeners();
  }

  void deleteTask(Task task){
         _tasks.remove(task);
         notifyListeners();
  }

}