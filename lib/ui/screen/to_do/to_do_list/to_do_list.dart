import 'package:flutter/material.dart';
import 'package:task_management_setu/common/base_page.dart';
import 'package:task_management_setu/common/base_screen.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> with BasePageState {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BaseScreen(
      title: "To Do",
      isAppShadowEffect: false,
      body: PopScope(
        canPop: false,
        onPopInvoked: (v) {
          if (v) {
            return;
          }
          onWillPop();
        },
        child: SizedBox(
          height: size.height,
          child: Center(
            child: Text("To Do List"),
          ),
        ),
      ),
    );
  }
}
