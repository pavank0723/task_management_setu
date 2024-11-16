part of 'view_to_do_screen_bloc.dart';

@immutable
sealed class ViewToDoScreenEvent {}

class FetchToDoDetail extends ViewToDoScreenEvent {
  final int id;
  FetchToDoDetail(this.id);
}

class UpdateToDoDetail extends ViewToDoScreenEvent {
  final ToDoModel newData;
  UpdateToDoDetail(this.newData);
}