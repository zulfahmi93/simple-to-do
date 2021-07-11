import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../db.dart';
import '../models/task.dart';

class AddTaskPage extends StatefulWidget {
  // ---------------------------- CONSTRUCTORS ----------------------------
  const AddTaskPage({
    Key? key,
    this.task,
  }) : super(key: key);

  // ------------------------------- FIELDS -------------------------------
  final Task? task;

  // ------------------------------- METHODS ------------------------------
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  // ------------------------------- FIELDS -------------------------------
  final _db = DbHelper();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _titleNode = FocusNode();
  final _descriptionNode = FocusNode();
  bool _add = false;
  int _taskId = 0;

  // ------------------------------- METHODS ------------------------------
  @override
  void initState() {
    super.initState();
    if (widget.task?.id != null) {
      _taskId = widget.task!.id!;
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
    } else {
      _add = true;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16.0, 40.0, 16.0, 100.0),
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(CupertinoIcons.arrow_left),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: TextField(
                  style: TextStyle(fontSize: 32.0),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'title',
                  ),
                  controller: _titleController,
                  focusNode: _titleNode,
                  onSubmitted: (v) async {
                    await _onSubmitted();
                    _descriptionNode.requestFocus();
                  },
                ),
              ),
            ],
          ),
          // SizedBox(height: 16.0),
          TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'description',
            ),
            controller: _descriptionController,
            focusNode: _descriptionNode,
            onSubmitted: (v) => _onSubmitted(),
          )
        ],
      ),
    );
  }

  Future<void> _onSubmitted() async {
    if (_add) {
      final task = Task(
        title: _titleController.text,
        description: _descriptionController.text,
      );
      _taskId = await _db.insertTask(task);
      _add = false;
    } else {
      final task = Task(
        id: _taskId,
        title: _titleController.text,
        description: _descriptionController.text,
      );
      await _db.updateTask(task);
    }
  }
}
