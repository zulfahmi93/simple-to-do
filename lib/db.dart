import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'models/task.dart';
import 'models/todo.dart';

class DbHelper {
  // ------------------------------- METHODS ------------------------------
  Future<int> insertTask(Task task) async {
    final db = await _getDatabase();
    return await db.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> insertToDo(ToDo toDo) async {
    final db = await _getDatabase();
    return await db.insert(
      'todos',
      toDo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateTask(Task task) async {
    final db = await _getDatabase();
    return await db.update(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> updateToDo(ToDo toDo) async {
    final db = await _getDatabase();
    return await db.update(
      'todos',
      toDo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
      where: 'id = ?',
      whereArgs: [toDo.id],
    );
  }

  Future<List<Task>> getTasks() async {
    final db = await _getDatabase();
    final rows = await db.query('tasks');
    return rows.map((e) => Task.fromMap(e)).toList();
  }

  Future<List<ToDo>> getToDos() async {
    final db = await _getDatabase();
    final rows = await db.query('todos');
    return rows.map((e) => ToDo.fromMap(e)).toList();
  }

  Future<Task?> getTaskById(int taskId) async {
    final db = await _getDatabase();
    final rows = await db.query('tasks', where: 'id = ?', whereArgs: [taskId]);
    return rows.length > 0 ? Task.fromMap(rows.first) : null;
  }

  Future<ToDo?> getToDoById(int toDoId) async {
    final db = await _getDatabase();
    final rows = await db.query('todos', where: 'id = ?', whereArgs: [toDoId]);
    return rows.length > 0 ? ToDo.fromMap(rows.first) : null;
  }

  Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'todo.db'),
      onCreate: (db, version) async {
        await db.execute('CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, description TEXT)');
        await db.execute('CREATE TABLE todos(id INTEGER PRIMARY KEY, taskId INTEGER, title TEXT, isDone INTEGER)');
      },
      version: 1,
    );
  }
}
