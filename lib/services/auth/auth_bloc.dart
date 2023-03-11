import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justdoit/models/user.dart';
import 'package:justdoit/repos/auth_repo.dart';
import 'package:justdoit/repos/todo_repo.dart';
import 'package:justdoit/services/auth/auth_event.dart';
import 'package:justdoit/services/auth/auth_state.dart';
import 'package:justdoit/services/auth/form_status.dart';
import 'package:justdoit/services/cubits/pagemanager.dart';
import 'package:justdoit/services/gest/gest_bloc.dart';
import 'package:justdoit/services/gest/gest_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<LoginEvent>(_onEvent);
  }

  Future<void> _onEvent(LoginEvent event, Emitter<LoginState> emit) async {
    if (event is LoginNameChanged) {
      emit(state.copyWith(name: event.name));
    }
    // password update
    else if (event is LoginPasswordChanged) {
      emit(state.copyWith(password: event.password));
    }
    //form submitted
    else if (event is LoginSubmitted) {
      emit(state.copyWith(formStatus: FormSubmitting()));
      try {
        User? user = await AuthRepo().login(event.name, event.password);
        if (user == null) {
          throw Exception("No such user has been found !");
        }

        if (user != null) {
          emit(state.copyWith(formStatus: SubmissionSuccess(user)));
          event.context.read<GestBloc>().add(ChangeUserGEvent(user: user));
          event.context.read<GestBloc>().add(ChangeTodoListEvent(
              todos: await TodoRepo().getTasksOfUser(user)));
          BlocProvider.of<PageManager>(
            event.context,
          ).change(1);
        }
      } catch (e) {
        emit(state.copyWith(formStatus: SubmissionFailed(Exception(e))));
      }
    }
  }
}
