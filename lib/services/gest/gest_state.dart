import 'package:justdoit/models/task.dart';
import 'package:justdoit/models/user.dart';

class GestState {
  User? user;
  List<User> users;
  List<Task> todos;
  List<Task> displayedTodos;
  String? searchBox;

  GestState({
    required this.user,
    required this.users,
    required this.todos,
    required this.displayedTodos,
    required this.searchBox,
  });

  GestState copyWith({
    User? user,
    List<User>? users,
    List<Task>? todos,
    List<Task>? displayedTodos,
    String? searchBox,
  }) {
    return GestState(
      user: user ?? this.user,
      users: users ?? this.users,
      todos: todos ?? this.todos,
      displayedTodos: displayedTodos ?? this.displayedTodos,
      searchBox: searchBox ?? this.searchBox,
    );
  }
}

class InitGestState extends GestState {
  InitGestState({
    required super.user,
    required super.users,
    required super.todos,
    required super.displayedTodos,
    required super.searchBox,
  }) {
    init();
  }

  void init() async {
    user = user ?? User(id: "", name: "", password: "", email: "");
    users = [];
    todos = [];
    displayedTodos = todos;
    searchBox = "";
  }
}
