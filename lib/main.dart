import 'package:flutter/material.dart';
import 'package:task_management_setu/my_app.dart';
import 'package:task_management_setu/network/local/local.dart';
import 'package:task_management_setu/repository/repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeNotification();
  final ToDoRepository repository = ToDoRepository();
  await repository
      .scheduleAllNotifications(); // Schedule notifications for all tasks

  runApp(const MyApp());
}
