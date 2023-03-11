import 'package:bloc/bloc.dart';

class PageManager extends Cubit<int> {
  PageManager()
      : super(
          0,
        );

  void change(int newState) => emit(newState);
}
