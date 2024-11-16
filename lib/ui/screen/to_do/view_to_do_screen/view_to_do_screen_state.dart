part of 'view_to_do_screen_bloc.dart';

@immutable
sealed class ViewToDoScreenState {}

final class ViewToDoScreenInitial extends ViewToDoScreenState {}

class LoadingToDoDetail extends ViewToDoScreenState {}

class ReceivedViewToDoDetail extends ViewToDoScreenState {
  final ToDoModel toDoModel;

  ReceivedViewToDoDetail(this.toDoModel);
}

class SubmittedViewToDoSuccessful extends ViewToDoScreenState {
  final String msg;
  final msgType = ToastType.success;

  SubmittedViewToDoSuccessful(this.msg);
}

class SubmissionViewToDoFailed extends ViewToDoScreenState {
  final String msg;
  final msgType = ToastType.error;

  SubmissionViewToDoFailed(this.msg);
}

class ErrorViewToDoShow extends ViewToDoScreenState {
  final String msg;
  final msgType = ToastType.error;

  ErrorViewToDoShow(this.msg);
}
