import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/task_data.dart';
import 'models/Task.dart'; // <-- for TaskCategory & categoryLabel

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final controller = TextEditingController();
  TaskCategory category = TaskCategory.general; // NEW

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF757575),
      child: Container(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: 20 + MediaQuery.of(context).viewInsets.bottom,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // fit to content
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Add Task',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, color: Colors.black),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              autofocus: true,
              textAlign: TextAlign.center,
              onSubmitted: (_) => _submit(context, controller.text),
              decoration: const InputDecoration(
                hintText: 'Task title',
                border: UnderlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<TaskCategory>(
              value: category,
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
              items: TaskCategory.values
                  .where((c) => c != TaskCategory.all) // don’t allow “All”
                  .map((c) => DropdownMenuItem(
                value: c,
                child: Text(categoryLabel(c)),
              ))
                  .toList(),
              onChanged: (c) => setState(() => category = c ?? TaskCategory.general),
            ),
            const SizedBox(height: 10),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  Theme.of(context).colorScheme.primary,       // was Colors.lightBlueAccent
                ),
                foregroundColor: const MaterialStatePropertyAll(Colors.white),
              ),
              onPressed: () => _submit(context, controller.text),
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }

  void _submit(BuildContext context, String text) {
    final value = text.trim();
    if (value.isEmpty) return;
    context.read<TaskData>().addTask(value, category: category); // pass category
    Navigator.pop(context);
  }
}
