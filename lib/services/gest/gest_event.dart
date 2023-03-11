import 'package:flutter/cupertino.dart';
import 'package:justdoit/models/task.dart';
import 'package:justdoit/models/user.dart';

abstract class GestEvent {
  const GestEvent();
}

class ChangeUserGEvent extends GestEvent {
  final User user;

  const ChangeUserGEvent({
    required this.user,
  });
}

class ChangeTodoListEvent extends GestEvent {
  final List<Task> todos;

  const ChangeTodoListEvent({
    required this.todos,
  });
}

class ChangeUsersListEvent extends GestEvent {
  final List<User> users;

  const ChangeUsersListEvent({
    required this.users,
  });
}

class SearchTextChanged extends GestEvent {
  final BuildContext context;
  final String searchText;

  const SearchTextChanged({
    required this.context,
    required this.searchText,
  });
}

class ChangeDisplayedTodosEvent extends GestEvent {
  final String todoName;

  const ChangeDisplayedTodosEvent({
    required this.todoName,
  });
}
