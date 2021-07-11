import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../db.dart';
import '../models/task.dart';
import 'pg_add_task.dart';

class TaskListPage extends StatefulWidget {
  // ---------------------------- CONSTRUCTORS ----------------------------
  const TaskListPage({
    Key? key,
  }) : super(key: key);

  // ------------------------------- METHODS ------------------------------
  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  // ------------------------------- FIELDS -------------------------------
  final _db = DbHelper();
  late Future<List<Task>> _tasksFuture;

  // ------------------------------- METHODS ------------------------------
  @override
  void initState() {
    super.initState();
    _tasksFuture = _db.getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>>(
      future: _tasksFuture,
      builder: (context, snapshot) {
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(16.0),
                child: FlutterLogo(size: 48.0),
              ),
              SizedBox(height: 16.0),
              if (snapshot.data == null) ...[
                Spacer(),
                LinearProgressIndicator(),
              ] else if (snapshot.data!.isEmpty)
                Expanded(
                  child: Center(
                    child: Text('no tasks found'),
                  ),
                )
              else
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 100.0),
                    itemCount: snapshot.data!.length,
                    separatorBuilder: (_, __) => SizedBox(height: 16.0),
                    itemBuilder: (_, i) => Card(
                      child: InkWell(
                        onTap: () => _openAddTaskPage(task: snapshot.data![i]),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data![i].title,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              SizedBox(height: 8.0),
                              Text(snapshot.data![i].description),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(CupertinoIcons.add),
            onPressed: () => _openAddTaskPage(),
          ),
        );
      },
    );
  }

  Future<void> _openAddTaskPage({Task? task}) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddTaskPage(task: task),
      ),
    );
    setState(() {
      _tasksFuture = _db.getTasks();
    });
  }
}
