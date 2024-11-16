part of 'add_to_do_screen_bloc.dart';

@immutable
sealed class AddToDoScreenEvent {}


class AddToDoDetail extends AddToDoScreenEvent {
  final ToDoModel toDo;

  AddToDoDetail(this.toDo);
}