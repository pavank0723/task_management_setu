import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:intl/intl.dart';
import 'package:task_management_setu/model/model.dart';
import 'package:task_management_setu/network/local/local.dart';
import 'package:task_management_setu/network/local/local_db/database_service.dart';

class ToDoRepository {
  final DataBaseService _databaseService = DataBaseService.instance;

  // Add To-Do
  Future<bool> addToDoDetail(ToDoModel newData) async {
    try {
      return await _databaseService.insertToDoData(newData);
    } catch (e) {
      throw Exception('Failed to add To-Do locally: $e');
    }
  }

  // Update To-Do
  Future<bool> updateToDoDetail(ToDoModel newData) async {
    try {
      return await _databaseService.updateToDoData(newData);
    } catch (e) {
      throw Exception('Failed to update To-Do locally: $e');
    }
  }

  // Delete To-Do
  Future<bool> deleteToDoDetail(int id) async {
    try {
      return await _databaseService.deleteToDoData(id);
    } catch (e) {
      throw Exception('Failed to delete To-Do locally: $e');
    }
  }

  // Get All To-Do List
  Future<List<ToDoModel>> getAllToDoDetails() async {
    try {
      return await _databaseService.getAllToDoList();
    } catch (e) {
      throw Exception('Failed to fetch all To-Dos: $e');
    }
  }

  // Schedule Notification for All To-Dos
  Future<void> scheduleAllNotifications() async {
    try {
      List<ToDoModel> toDoList = await getAllToDoDetails();

      for (var todo in toDoList) {
        if (todo.dueDate != null && todo.dueDate!.isNotEmpty) {
          // Use intl to parse the custom date format
          final DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm');
          final DateTime dueDate = formatter.parse(todo.dueDate!);


          final DateTime notificationTime =
          dueDate.subtract(const Duration(minutes: 15)); // Adjust as needed
          final int intervalSeconds = notificationTime.difference(DateTime.now()).inSeconds;

          if (intervalSeconds > 5) {
            await showNotification(
              title: "Task Reminder",
              body: "Your task '${todo.name}' is due soon!",
              notificationLayout: NotificationLayout.Default,
              scheduled: true,
              interval: intervalSeconds,
            );
          }
        }
      }
    } catch (e) {
      throw Exception('Failed to schedule notifications: $e');
    }
  }

  // Get To-Do Detail by ID
  Future<ToDoModel?> getToDoDetailById(int id) async {
    try {
      return await _databaseService.getToDoDetail(id);
    } catch (e) {
      throw Exception('Failed to fetch To-Do by ID: $e');
    }
  }

  // Update To-Do Status (Completed or Not Completed)
  Future<bool> updateToDoStatus(int id, bool isComplete) async {
    try {
      return await _databaseService.updateToDoStatus(id, isComplete);
    } catch (e) {
      throw Exception('Failed to update To-Do status: $e');
    }
  }
}
