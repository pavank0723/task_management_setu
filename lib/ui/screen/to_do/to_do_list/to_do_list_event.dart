part of 'to_do_list_bloc.dart';

@immutable
sealed class ToDoListEvent {}

class LoadToDos extends ToDoListEvent {}

class SearchToDo extends ToDoListEvent {
  final String query;

  SearchToDo(this.query);
}

class UpdateToDo extends ToDoListEvent {
  final int toDoId;
  final bool status;

  UpdateToDo(this.toDoId,this.status);
}

class DeleteToDo extends ToDoListEvent {
  final int toDoId;

  DeleteToDo(this.toDoId);
}
