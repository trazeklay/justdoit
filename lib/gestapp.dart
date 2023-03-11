import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justdoit/services/auth/auth_bloc.dart';
import 'package:justdoit/services/cubits/obscure_password.dart';
import 'package:justdoit/services/cubits/pagemanager.dart';
import 'package:justdoit/services/gest/gest_bloc.dart';
import 'package:justdoit/views/main_page.dart';

class GestApp extends MaterialApp {
  GestApp({
    super.key,
  }) : super(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<GestBloc>(
                create: (_) => GestBloc(),
              ),
              BlocProvider<LoginBloc>(
                create: (_) => LoginBloc(),
              ),
              BlocProvider<ObscurePasswordCubit>(
                create: (_) => ObscurePasswordCubit(),
              ),
              BlocProvider<PageManager>(
                create: (_) => PageManager(),
              ),
            ],
            child: const MainView(),
          ),
          debugShowCheckedModeBanner: false,
        );
}
