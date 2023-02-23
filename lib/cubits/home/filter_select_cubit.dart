import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterSelectCubit extends Cubit<int> {
  FilterSelectCubit() : super(1);

  void selectOption(int option) {
    emit(option);
  }
}
