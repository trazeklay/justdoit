import 'package:flutter/material.dart';
import 'package:justdoit/utils/const.dart';

class EmptyTodoListPage extends StatelessWidget {
  const EmptyTodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Pas de tâches en cours",
            style: TextStyle(
              color: AppColors.white,
              fontFamily: AppResources.defaultFont,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
