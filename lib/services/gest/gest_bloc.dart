import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justdoit/models/task.dart';
import 'package:justdoit/services/gest/gest_event.dart';
import 'package:justdoit/services/gest/gest_state.dart';

class GestBloc extends Bloc<GestEvent, GestState> {
  GestBloc()
      : super(
          InitGestState(
            user: null,
            users: [],
            todos: [],
            displayedTodos: [],
            searchBox: "",
          ),
        ) {
    on<GestEvent>(onGestEvent);
  }

  void onGestEvent(event, emit) async {
    if (event is ChangeUserGEvent) {
      emit(state.copyWith(user: event.user));
    }
    if (event is ChangeTodoListEvent) {
      emit(state.copyWith(todos: event.todos, displayedTodos: event.todos));
    } else if (event is SearchTextChanged) {
      event.context.read<GestBloc>().add(
          ChangeDisplayedTodosEvent(todoName: event.searchText.toLowerCase()));
      emit(state.copyWith(searchBox: event.searchText));
    } else if (event is ChangeUsersListEvent) {
      emit(state.copyWith(users: event.users));
    } else if (event is ChangeDisplayedTodosEvent) {
      final List<Task> newTasks = [];

      for (var todo in state.todos) {
        if (todo.name.toLowerCase().startsWith(event.todoName)) {
          newTasks.add(todo);
        }
      }

      if (event.todoName == '') {
        emit(state.copyWith(displayedTodos: newTasks));
      } else {
        emit(state.copyWith(displayedTodos: newTasks));
      }
    }
  }
}
