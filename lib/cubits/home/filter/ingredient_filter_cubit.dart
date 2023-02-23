import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IngredientFilterCubit extends Cubit<List> {
  IngredientFilterCubit() : super([]);

  void addItem(String item) {
    final newList = List<String>.from(state)..add(item);
    emit(newList);
  }

  void removeItem(String item) {
    state.remove(item);
    emit(state.toList());
  }

  void reset() {
    emit([]);
  }
}
