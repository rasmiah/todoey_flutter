import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/task_data.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return Container(
      color: const Color(0xFF757575),
      child: Container(
        padding: EdgeInsets.only(
          left: 20, right: 20, top: 20,
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
              style: TextStyle(fontSize: 30, color: Colors.lightBlueAccent),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              autofocus: true,
              textAlign: TextAlign.center,
              onSubmitted: (_) => _submit(context, controller.text),
            ),
            const SizedBox(height: 10),
            TextButton(
              style: ButtonStyle(
                backgroundColor:
                MaterialStatePropertyAll(Colors.lightBlueAccent),
              ),
              onPressed: () => _submit(context, controller.text),
              child: const Text('Add', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  void _submit(BuildContext context, String text) {
    final value = text.trim();
    if (value.isEmpty) return;
    context.read<TaskData>().addTask(value);
    Navigator.pop(context);
  }
}
