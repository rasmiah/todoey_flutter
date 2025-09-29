// lib/tasks_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/task_data.dart';
import 'models/Task.dart';            // for TaskCategory & categoryLabel
import 'theme_provider.dart';  // for theme toggle
import 'Widgets/taskList.dart';       // your existing list widget
import 'add_task_screen.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskData = context.watch<TaskData>();
    final count = taskData.taskCount;
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Todoey'),
        actions: [
          // Filter menu
          Consumer<TaskData>(
            builder: (context, data, _) {
              return PopupMenuButton<TaskCategory>(
                tooltip: 'Filter tasks',
                initialValue: data.activeFilter,
                icon: const Icon(Icons.filter_list),
                onSelected: (c) => data.setFilter(c),
                itemBuilder: (context) => TaskCategory.values.map((c) {
                  final isSelected = data.activeFilter == c;
                  return PopupMenuItem(
                    value: c,
                    child: Row(
                      children: [
                        if (isSelected) const Icon(Icons.check, size: 16),
                        if (isSelected) const SizedBox(width: 8),
                        Text(categoryLabel(c)),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          ),
          // Theme toggle
          IconButton(
            tooltip: 'Toggle theme',
            icon: const Icon(Icons.brightness_6),
            onPressed: () => context.read<ThemeProvider>().toggle(),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => const AddTaskScreen(),
          );
        },
        child: const Icon(Icons.add),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Count strip under the AppBar that adapts to theme
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            color: cs.primary,
            child: Text(
              '$count ${count == 1 ? "task" : "tasks"}',
              style: TextStyle(
                color: cs.onPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // Optional: show active filter chip (tap the "x" to clear)
          if (taskData.activeFilter != TaskCategory.all)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: InputChip(
                label: Text('Filter: ${categoryLabel(taskData.activeFilter)}'),
                onDeleted: () =>
                    context.read<TaskData>().setFilter(TaskCategory.all),
              ),
            ),

          // Tasks list area (rounded surface)
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: cs.surface,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20),
                ),
              ),
              child: const TaskList(),
            ),
          ),
        ],
      ),
    );
  }
}
