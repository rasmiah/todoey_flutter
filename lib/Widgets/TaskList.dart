import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task_data.dart';
import 'TaskTile.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        final items = taskData.tasks;
        if (items.isEmpty) {
          return const Center(child: Text('No tasks yet'));
        }
        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final task = items[index];
            return TaskTile(
              taskTitle: task.name,
              isChecked: task.isDone,
              checkBoxCallback: (_) => taskData.updateTask(task),
              longPressCallback: () => taskData.deleteTask(task),
            );
          },
        );
      },
    );
  }
}
