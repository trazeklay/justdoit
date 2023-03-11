import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justdoit/services/auth/auth_bloc.dart';
import 'package:justdoit/services/auth/auth_event.dart';
import 'package:justdoit/services/auth/auth_state.dart';
import 'package:justdoit/services/auth/form_status.dart';
import 'package:justdoit/services/cubits/obscure_password.dart';
import 'package:justdoit/utils/const.dart';

class LoginPage extends StatelessWidget {
  final _nameTEC = TextEditingController();
  final _passwordTEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      body: SafeArea(
        child: SingleChildScrollView(
          child: _loginForm(),
        ),
      ),
    );
  }

  Widget _loginForm() {
    return Form(
      key: _formKey,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 60,
            ),

            // Icône de compte
            const Icon(
              Ionicons.person_outline,
              color: AppColors.white,
              size: 100,
            ),

            //
            const SizedBox(
              height: 60,
            ),

            // Title
            _title(AppResources.welcomeTitle),

            //
            const SizedBox(
              height: 20,
            ),

            _subtitle(AppResources.welcomeSubtitle),

            //
            const SizedBox(
              height: 80,
            ),

            // Username field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border.all(color: AppColors.white),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return TextFormField(
                        style: TextStyle(
                          fontFamily: AppResources.defaultFont,
                          color: AppColors.black,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: AppResources.usernameHint,
                          hintStyle: TextStyle(
                            color: AppColors.lightGray,
                          ),
                        ),
                        validator: (value) => state.isValidUsername
                            ? null
                            : AppResources.onUsernameNull,
                        onChanged: (value) => context.read<LoginBloc>().add(
                              LoginNameChanged(name: value),
                            ),
                        controller: _nameTEC,
                      );
                    },
                  ),
                ),
              ),
            ),

            //
            const SizedBox(
              height: 30,
            ),

            // Password field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, loginState) {
                      return BlocBuilder<ObscurePasswordCubit, bool>(
                        builder: (context, obscureState) => TextFormField(
                          style: TextStyle(
                            fontFamily: AppResources.defaultFont,
                            color: AppColors.black,
                          ),
                          obscureText: obscureState,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: AppResources.passwordHint,
                            hintStyle: const TextStyle(
                              color: AppColors.lightGray,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () =>
                                  BlocProvider.of<ObscurePasswordCubit>(
                                context,
                              ).change(),
                              icon: obscureState
                                  ? const Icon(Ionicons.eye_outline)
                                  : const Icon(Ionicons.eye_off_outline),
                            ),
                          ),
                          validator: (value) => loginState.isValidPassword
                              ? null
                              : AppResources.onPasswordNull,
                          onChanged: (value) => context.read<LoginBloc>().add(
                                LoginPasswordChanged(password: value),
                              ),
                          controller: _passwordTEC,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            //
            const SizedBox(
              height: 50,
            ),

            // Log in button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.aqua,
                ),
                child: BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, loginState) {
                    if (loginState.formStatus is FormSubmitting) {
                      return const SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.white,
                          ),
                        ),
                      );
                    } else {
                      return TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<LoginBloc>().add(
                                  LoginSubmitted(
                                    name: _nameTEC.text,
                                    password: _passwordTEC.text,
                                    context: context,
                                  ),
                                );
                          }
                        },
                        child: Center(
                          child: Text(
                            AppResources.loginBtnText,
                            style: TextStyle(
                              color: AppColors.white,
                              fontFamily: AppResources.defaultFont,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title(String title) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: AppResources.defaultFont,
        fontSize: 25,
        color: AppColors.white,
      ),
    );
  }

  Widget _subtitle(String subtitle) {
    return Text(
      subtitle,
      style: TextStyle(
        fontFamily: AppResources.defaultFont,
        fontSize: 19,
        color: AppColors.white,
      ),
    );
  }
}
