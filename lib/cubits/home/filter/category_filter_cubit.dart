import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryFilterCubit extends Cubit<List> {
  CategoryFilterCubit() : super([]);

  void selectItem(String item) {
    final newList = List<String>.from(state)..add(item);
    emit(newList);
  }

  void deselectItem(String item) {
    state.remove(item);
    emit(state.toList());
  }

  void reset() {
    emit([]);
  }
}
