import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/task_data.dart';
import 'tasks_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TaskData(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TasksScreen(),
      ),
    ),
  );
}
