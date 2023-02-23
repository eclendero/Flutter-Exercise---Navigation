import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'filter_cubit.dart';

class PriceLimitFilterCubit extends Cubit<String> {
  PriceLimitFilterCubit() : super('');

  void selectItem(String item) {
    // var instance = FilterCubit();
    // instance.store({'priceLimit': item});
    emit(item);
  }

  void reset() {
    // var instance = FilterCubit();
    // instance.store({'priceLimit': ''});
    emit('');
  }
}
