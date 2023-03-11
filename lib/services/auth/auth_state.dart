import 'package:justdoit/services/auth/form_status.dart';

class LoginState {
  final String name;
  bool get isValidUsername => name != "";

  final String password;
  bool get isValidPassword => password != "";

  final FormSubmissionStatus formStatus;

  LoginState({
    this.name = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
  });

  LoginState copyWith({
    String? name,
    String? password,
    FormSubmissionStatus? formStatus,
  }) {
    return LoginState(
      name: name ?? this.name,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
