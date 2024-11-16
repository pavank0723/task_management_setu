part of 'add_to_do_screen_bloc.dart';

@immutable
sealed class AddToDoScreenState {}

final class AddToDoScreenInitial extends AddToDoScreenState {}

class LoadingToDoDetail extends AddToDoScreenState {}

class ToDoAddedSuccessfully extends AddToDoScreenState {}

class ToDoAddedFailed extends AddToDoScreenState {}

class ErrorToDoDetail extends AddToDoScreenState {
  final String message;

  ErrorToDoDetail(this.message);
}
