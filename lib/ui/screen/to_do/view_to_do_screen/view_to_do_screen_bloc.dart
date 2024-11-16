import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_management_setu/model/local/local.dart';
import 'package:task_management_setu/repository/repository.dart';
import 'package:task_management_setu/util/util.dart';

part 'view_to_do_screen_event.dart';

part 'view_to_do_screen_state.dart';

class ViewToDoScreenBloc
    extends Bloc<ViewToDoScreenEvent, ViewToDoScreenState> {
  final ToDoRepository _toDoRepository;

  ViewToDoScreenBloc(this._toDoRepository) : super(ViewToDoScreenInitial()) {
    on<FetchToDoDetail>(_onFetchToDoDetail);

    on<UpdateToDoDetail>(_onUpdateToDoDetail);
  }

  Future<void> _onFetchToDoDetail(
      FetchToDoDetail event, Emitter<ViewToDoScreenState> emit) async {
    emit(LoadingToDoDetail());
    try {
      final toDoDetail = await _toDoRepository.getToDoDetailById(event.id);
      if (toDoDetail != null) {
        emit(ReceivedViewToDoDetail(toDoDetail));
      } else {
        emit(ErrorViewToDoShow('To-Do not found'));
      }
    } catch (e) {
      emit(ErrorViewToDoShow('Failed to fetch To-Do: ${e.toString()}'));
    }
  }

  Future<void> _onUpdateToDoDetail(
      UpdateToDoDetail event, Emitter<ViewToDoScreenState> emit) async {
    emit(LoadingToDoDetail());
    try {
      bool result = await _toDoRepository.updateToDoDetail(event.newData);
      result
          ? emit(SubmittedViewToDoSuccessful('To-Do updated successfully'))
          : emit(SubmissionViewToDoFailed('Failed to update To-Do'));
    } catch (e) {
      emit(ErrorViewToDoShow('Failed to update To-Do: ${e.toString()}'));
    }
  }
}
