import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:task_management_setu/model/model.dart';

Future<void> createToDoTable(Database db, int version) async {
  await db.execute('''
    CREATE TABLE ToDo(
      ID INTEGER PRIMARY KEY,
      Name TEXT NOT NULL,
      Description TEXT,
      DueDate TEXT,
      IsCompleted INTEGER DEFAULT 0,
      IsActive INTEGER DEFAULT 1,
      AddedOn TEXT,
      UpdatedOn TEXT
    )
  ''');
}

Future<bool> addToDo(Database db, ToDoModel todo) async {
  try {
    int result = await db.rawInsert(
      'INSERT INTO ToDo '
      '(Name, Description, DueDate, IsCompleted,IsActive, AddedOn) '
      'VALUES (?, ?, ?, ?,?, ?)',
      [
        todo.name,
        todo.description,
        todo.dueDate,
        0,
        1,
        DateTime.now().toString(),
      ],
    );

    // Return true if a row was successfully inserted (result > 0).
    return result > 0;
  } catch (e) {
    // Log the error and return false.
    debugPrint('Error inserting ToDo: $e');
    return false;
  }
}

Future<bool> updateToDo(Database db, ToDoModel todo) async {
  try {
    int result = await db.rawUpdate(
      'UPDATE ToDo SET '
      'Name = ?, '
      'Description = ?, '
      'DueDate = ?, '
      'UpdatedOn = ? '
      'WHERE ID = ?',
      [
        todo.name,
        todo.description,
        todo.dueDate,
        DateTime.now().toString(),
        todo.id,
      ],
    );
    debugPrint("UPDATE Status >>>> $result");
    return result > 0;
  } catch (e) {
    debugPrint('Error during update: $e');
    return false;
  }
}

Future<bool> deleteToDo(Database db, int id) async {
  try {
    int result = await db.rawUpdate(
      'UPDATE ToDo SET '
      'IsActive = ?, '
      'UpdatedOn = ? '
      'WHERE ID = ?',
      [
        0,
        DateTime.now().toString(),
        id,
      ],
    );
    return result > 0;
  } catch (e) {
    debugPrint('Error delete ToDo: $e');
    return false;
  }
}

Future<List<ToDoModel>> getAllToDos(Database db) async {
  final List<Map<String, dynamic>> maps =
      await db.query('ToDo', where: 'IsActive = ?', whereArgs: [1]);

  debugPrint('Fetched Active ToDos: $maps');

  return List.generate(maps.length, (i) {
    return ToDoModel.fromMap(maps[i]);
  });
}

Future<ToDoModel?> getToDoById(Database db, int id) async {
  final List<Map<String, dynamic>> maps = await db.query(
    'ToDo',
    where: 'ID = ?',
    whereArgs: [id],
    limit: 1,
  );

  if (maps.isNotEmpty) {
    return ToDoModel.fromMap(maps.first);
  } else {
    return null;
  }
}

Future<bool> updateStatus(Database db, int id, bool isComplete) async {
  try {
    int result = await db.update(
      'ToDo',
      {'IsCompleted': isComplete ? 1 : 0},
      where: 'ID = ?',
      whereArgs: [id],
    );

    // Return true if one or more rows were updated.
    return result > 0;
  } catch (e) {
    // Log the error and return false.
    debugPrint('Error updating status for ToDo with ID $id: $e');
    return false;
  }
}
