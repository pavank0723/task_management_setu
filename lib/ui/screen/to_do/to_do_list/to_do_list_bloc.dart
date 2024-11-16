import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_management_setu/model/model.dart';
import 'package:task_management_setu/repository/repository.dart';

part 'to_do_list_event.dart';

part 'to_do_list_state.dart';

class ToDoListBloc extends Bloc<ToDoListEvent, ToDoListState> {
  final ToDoRepository _toDoRepository;

  List<ToDoModel> allToDos = [];
  List<ToDoModel> displayedToDos = [];

  ToDoListBloc(this._toDoRepository) : super(ToDoListInitial()) {
    on<LoadToDos>(_onLoadTasks);
    on<UpdateToDo>(_onToggleToDoCompletion);
    on<DeleteToDo>(_onDeleteToDo);
    on<SearchToDo>(_onSearchToDo);
  }

  Future<void> _onLoadTasks(
      LoadToDos event, Emitter<ToDoListState> emit) async {
    emit(LoadingToDo());
    try {
      final List<ToDoModel> toDos = await _toDoRepository.getAllToDoDetails();

      final activeToDos = toDos.where((toDo) => toDo.isActive!).toList();

      allToDos.clear();
      allToDos.addAll(activeToDos);

      displayedToDos = List.from(allToDos);

      displayedToDos.isNotEmpty
          ? emit(LoadedToDo(displayedToDos))
          : emit(NoToDoAvailable());
    } catch (e) {
      emit(ErrorToDo('Failed to load To-Dos: ${e.toString()}'));
    }
  }

  // Method to toggle To-Do completion status
  Future<void> _onToggleToDoCompletion(
      UpdateToDo event, Emitter<ToDoListState> emit) async {
    try {
      final bool isUpdated = await _toDoRepository.updateToDoStatus(
        event.toDoId,
        event.status, // or false depending on toggle logic
      );
      if (isUpdated) {
        emit(UpdateStatusToDoSuccessfully());
        // Reload the list after status update
        add(LoadToDos());
      } else {
        emit(UpdateToDoFailed());
      }
    } catch (e) {
      emit(ErrorToDo('Failed to update To-Do status: ${e.toString()}'));
    }
  }

  // Method to delete a To-Do
  Future<void> _onDeleteToDo(
      DeleteToDo event, Emitter<ToDoListState> emit) async {
    try {
      final bool isDeleted = await _toDoRepository.deleteToDoDetail(
        event.toDoId,
      );
      if (isDeleted) {
        emit(DeletedToDoSuccessfully());
        // Reload the list after deletion
        add(LoadToDos());
      } else {
        emit(DeletedToDoFailed());
      }
    } catch (e) {
      emit(ErrorToDo('Failed to delete To-Do: ${e.toString()}'));
    }
  }

  // Method to search To-Dos
  Future<void> _onSearchToDo(
      SearchToDo event, Emitter<ToDoListState> emit) async {
    emit(LoadingToDo());
    await Future.delayed(const Duration(milliseconds: 100));

    displayedToDos = allToDos.where((toDo) {
      String? titleQuery = toDo.name?.toLowerCase();
      String? descriptionQuery = toDo.description?.toLowerCase();
      // Combine title and description for the search
      String fullText = '${titleQuery ?? ''} ${descriptionQuery ?? ''}';
      return fullText.contains(event.query.toLowerCase());
    }).toList();

    if (displayedToDos.isNotEmpty) {
      emit(LoadedToDo(displayedToDos));
    } else {
      if (event.query.isNotEmpty) {
        emit(NoSearchToDoAvailable());
      } else {
        emit(NoToDoAvailable()); // Reset to all To-Dos when query is empty
      }
    }
  }
}
