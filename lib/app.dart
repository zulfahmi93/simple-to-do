import 'package:flutter/material.dart';

import 'ui/pg_task_list.dart';

class ToDoApp extends StatelessWidget {
  // ---------------------------- CONSTRUCTORS ----------------------------
  const ToDoApp({
    Key? key,
  }) : super(key: key);

  // ------------------------------- METHODS ------------------------------
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beautiful To-Do',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.purple,
      ),
      home: const TaskListPage(),
    );
  }
}
