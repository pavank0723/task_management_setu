part of 'to_do_list_bloc.dart';

@immutable
sealed class ToDoListState {}

final class ToDoListInitial extends ToDoListState {}

class LoadingToDo extends ToDoListState {}

class LoadedToDo extends ToDoListState {
  final List<ToDoModel> toDos;

  LoadedToDo(this.toDos);
}

class UpdateStatusToDoSuccessfully extends ToDoListState {}

class UpdateToDoFailed extends ToDoListState {}

class DeletedToDoSuccessfully extends ToDoListState {}

class DeletedToDoFailed extends ToDoListState {}

class NoToDoAvailable extends ToDoListState {}

class NoSearchToDoAvailable extends ToDoListState {}

class ErrorToDo extends ToDoListState {
  final String message;

  ErrorToDo(this.message);
}
