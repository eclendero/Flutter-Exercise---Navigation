import 'package:flutter_bloc/flutter_bloc.dart';

//Monitor whether to search in 'All', 'My Recipes', or 'Suggested'
class SearchOptionCubit extends Cubit<int> {
  SearchOptionCubit() : super(1);

  void selectOption(int option) {
    emit(option);
  }
}
