import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justdoit/services/cubits/pagemanager.dart';
import 'package:justdoit/views/errors/not_found_page.dart';
import 'package:justdoit/views/login_page.dart';
import 'package:justdoit/views/todos_page.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageManager, int>(
      builder: (context, pageManagerState) {
        switch (pageManagerState) {
          case 0:
            return LoginPage();
          case 1:
            return const TodosPage();
          default:
            return const PageNotFound();
        }
      },
    );
  }
}
