import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_setu/repository/repository.dart';
import 'package:task_management_setu/ui/screen/screen.dart';
import 'package:task_management_setu/ui/screen/to_do/to_do_list/to_do_list_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ToDoListBloc(
        RepositoryProvider.of<ToDoRepository>(context),
      ),
      child: const ToDoList(),
    );
  }
}
