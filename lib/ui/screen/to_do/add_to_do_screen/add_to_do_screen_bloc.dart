import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_management_setu/model/model.dart';
import 'package:task_management_setu/repository/repository.dart';

part 'add_to_do_screen_event.dart';

part 'add_to_do_screen_state.dart';

class AddToDoScreenBloc extends Bloc<AddToDoScreenEvent, AddToDoScreenState> {
  final ToDoRepository _toDoRepository;

  AddToDoScreenBloc(this._toDoRepository) : super(AddToDoScreenInitial()) {
    on<AddToDoDetail>(_onAddToDoDetail);
  }

  Future<void> _onAddToDoDetail(
      AddToDoDetail event, Emitter<AddToDoScreenState> emit) async {
    try {
      bool result = await _toDoRepository.addToDoDetail(event.toDo);
      result ? emit(ToDoAddedSuccessfully()) : emit(ToDoAddedFailed());
    } catch (e) {
      emit(ErrorToDoDetail('Failed to add to do'));
    }
  }
}
