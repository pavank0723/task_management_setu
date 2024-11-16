import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:task_management_setu/model/model.dart';
import 'package:task_management_setu/network/local/local_db/queries/queries.dart';

class DataBaseService {
  static final DataBaseService instance = DataBaseService._init();

  DataBaseService._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'task_management_setu.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await createToDoTable(db, version);
  }

  Future<bool> insertToDoData(ToDoModel newData) async {
    Database db = await database;

    try {
      return await addToDo(db, newData);
    } catch (e) {
      debugPrint('Error inserting local data: $e');
      // Handle error
      rethrow;
    }
  }

  Future<bool> updateToDoData(ToDoModel newData) async {
    Database db = await database;

    try {
      return await updateToDo(db, newData);
    } catch (e) {
      debugPrint('Error updating local data: $e');
      rethrow;
      // Handle error
    }
  }

  Future<bool> deleteToDoData(int id) async {
    Database db = await database;

    try {
      return await deleteToDo(db, id);
    } catch (e) {
      debugPrint('Error delete to do local data: $e');
      rethrow;
      // Handle error
    }
  }

  Future<List<ToDoModel>> getAllToDoList() async {
    Database db = await database;

    try {
      final List<Map<String, dynamic>> result = await db.query(
        'ToDo',
        orderBy: 'AddedOn DESC', // Order by AddedOn in descending order
      );

      // Convert the result to a list of ToDoModel
      List<ToDoModel> data = result.map((e) => ToDoModel.fromMap(e)).toList();
      return data;
    } catch (e) {
      debugPrint('Error fetching To-Do data: $e');
      rethrow;
    }
  }


  Future<ToDoModel?> getToDoDetail(int id) async {
    Database db = await database;

    try {
      ToDoModel? data = await getToDoById(db, id);
      return data;
    } catch (e) {
      debugPrint('Error delete to do local data: $e');
      rethrow;
      // Handle error
    }
  }

  Future<bool> updateToDoStatus(int id, bool isComplete) async {
    Database db = await database;

    try {
      return await updateStatus(db, id, isComplete);
    } catch (e) {
      debugPrint('Error delete to do local data: $e');
      rethrow;
      // Handle error
    }
  }
}
