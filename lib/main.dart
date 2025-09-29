// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/task_data.dart';
import 'theme_provider.dart'; // make sure this file exists as we discussed
import 'tasks_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ToDoeyAppRoot());
}

class ToDoeyAppRoot extends StatelessWidget {
  const ToDoeyAppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskData()),
        // loads saved theme (light/dark/system) from SharedPreferences
        ChangeNotifierProvider(create: (_) => ThemeProvider()..load()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, theme, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: theme.mode,
            theme: ThemeData(
              useMaterial3: true,
              // Pick any seed color you like — everything derives from this.
              colorSchemeSeed: Colors.lightBlueAccent,
              brightness: Brightness.light,
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorSchemeSeed: Colors.lightBlueAccent,
              brightness: Brightness.dark,
            ),
            home: const TasksScreen(),
          );
        },
      ),
    );
  }
}
