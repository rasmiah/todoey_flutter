import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/task_data.dart';
import 'Widgets/taskList.dart';
import 'add_task_screen.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final count = context.watch<TaskData>().taskCount;

    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true, // keyboard-safe
            builder: (_) => const AddTaskScreen(),
          );
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: Colors.lightBlueAccent),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding:
            const EdgeInsets.only(top: 60, left: 30, bottom: 20, right: 30),
            child: Row(
              children: const [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 28,
                  child: Icon(Icons.list, size: 30, color: Colors.lightBlueAccent),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Todoey',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              '$count ${count == 1 ? "task" : "tasks"}',
              style: const TextStyle(
                  color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
            ),
          ),
          const SizedBox(height: 10),
          // List
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20),
                ),
              ),
              child: const TaskList(), // scrollable list (ListView.builder)
            ),
          ),
        ],
      ),
    );
  }
}
