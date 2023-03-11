import 'package:flutter/cupertino.dart';

abstract class LoginEvent {}

class LoginNameChanged extends LoginEvent {
  final String name;

  LoginNameChanged({
    required this.name,
  });
}

class LoginPasswordChanged extends LoginEvent {
  final String password;

  LoginPasswordChanged({
    required this.password,
  });
}

class LoginSubmitted extends LoginEvent {
  final String name;
  final String password;
  final BuildContext context;

  LoginSubmitted({
    required this.name,
    required this.password,
    required this.context,
  });
}
