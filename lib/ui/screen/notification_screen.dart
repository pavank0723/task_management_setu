import 'package:flutter/material.dart';
import 'package:task_management_setu/common/base_screen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "Notification",
      body: Column(),
    );
  }
}
